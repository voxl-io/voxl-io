function onLoad () {
  Blaze._DOMMaterializer.def({
    visitTag: function (tag, intoArray) {
      console.log(tag);
      var self = this;
      var tagName = tag.tagName;
      var elem;
      if ((HTML.isKnownSVGElement(tagName) || isSVGAnchor(tag))
          && document.createElementNS) {
        // inline SVG
        elem = document.createElementNS('http://www.w3.org/2000/svg', tagName);
      } else if (false) {

      } else {
        // normal elements
        elem = document.createElement(tagName);
      }

      var rawAttrs = tag.attrs;
      var children = tag.children;
      if (tagName === 'textarea' && tag.children.length &&
          ! (rawAttrs && ('value' in rawAttrs))) {
        // Provide very limited support for TEXTAREA tags with children
        // rather than a "value" attribute.
        // Reactivity in the form of Views nested in the tag's children
        // won't work.  Compilers should compile textarea contents into
        // the "value" attribute of the tag, wrapped in a function if there
        // is reactivity.
        if (typeof rawAttrs === 'function' ||
            HTML.isArray(rawAttrs)) {
          throw new Error("Can't have reactive children of TEXTAREA node; " +
                          "use the 'value' attribute instead.");
        }
        rawAttrs = _.extend({}, rawAttrs || null);
        rawAttrs.value = Blaze._expand(children, self.parentView);
        children = [];
      }

      if (rawAttrs) {
        var attrUpdater = new ElementAttributesUpdater(elem);
        var updateAttributes = function () {
          var parentView = self.parentView;
          var expandedAttrs = Blaze._expandAttributes(rawAttrs, parentView);
          var flattenedAttrs = HTML.flattenAttributes(expandedAttrs);
          var stringAttrs = {};
          for (var attrName in flattenedAttrs) {
            stringAttrs[attrName] = Blaze._toText(flattenedAttrs[attrName],
                                                  parentView,
                                                  HTML.TEXTMODE.STRING);
          }
          attrUpdater.update(stringAttrs);
        };
        var updaterComputation;
        if (self.parentView) {
          updaterComputation = self.parentView.autorun(updateAttributes);
        } else {
          updaterComputation = Tracker.nonreactive(function () {
            return Tracker.autorun(function () {
              Tracker._withCurrentView(self.parentView, updateAttributes);
            });
          });
        }
        Blaze._DOMBackend.Teardown.onElementTeardown(elem, function attrTeardown() {
          updaterComputation.stop();
        });
      }

      var childNodesAndRanges = self.visit(children, []);
      for (var i = 0; i < childNodesAndRanges.length; i++) {
        var x = childNodesAndRanges[i];
        if (x instanceof Blaze._DOMRange)
          x.attach(elem);
        else
          elem.appendChild(x);
      }

      intoArray.push(elem);

      return intoArray;
    }
  });
}

$(window).load(onLoad);
