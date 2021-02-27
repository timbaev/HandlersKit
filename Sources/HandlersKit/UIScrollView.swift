//
// HandlersKit
// Copyright © 2020 HeadHunter
// MIT Licence
//

#if canImport(UIKit)
import UIKit

extension HandlersKit where Self: UIScrollView {

    @discardableResult
    public func didScroll(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didScroll = handler }
    }

    @discardableResult
    public func didScroll(handler: @escaping () -> Void) -> Self {
        didScroll { _ in handler() }
    }

    // MARK: -

    @discardableResult
    public func didZoom(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didZoom = handler }
    }

    @discardableResult
    public func didZoom(handler: @escaping () -> Void) -> Self {
        didZoom { _ in handler() }
    }

    // MARK: -

    @discardableResult
    public func willBeginDragging(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.willBeginDragging = handler }
    }

    @discardableResult
    public func willBeginDragging(handler: @escaping () -> Void) -> Self {
        willBeginDragging { _ in handler() }
    }

    // MARK: -

    @discardableResult
    public func willEndDragging(handler: @escaping (Self, CGPoint, UnsafeMutablePointer<CGPoint>) -> Void) -> Self {
        updateObserver { $0.willEndDragging = handler }
    }

    @discardableResult
    public func willEndDragging(handler: @escaping (CGPoint, UnsafeMutablePointer<CGPoint>) -> Void) -> Self {
        willEndDragging { handler($1, $2) }
    }

    // MARK: -

    @discardableResult
    public func didEndDragging(handler: @escaping (Self, Bool) -> Void) -> Self {
        updateObserver { $0.didEndDragging = handler }
    }

    @discardableResult
    public func didEndDragging(handler: @escaping (Bool) -> Void) -> Self {
        didEndDragging { handler($1) }
    }

    // MARK: -

    @discardableResult
    public func willBeginDecelerating(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.willBeginDecelerating = handler }
    }

    @discardableResult
    public func willBeginDecelerating(handler: @escaping () -> Void) -> Self {
        willBeginDecelerating { _ in handler() }
    }

    // MARK: -

    @discardableResult
    public func didEndDecelerating(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didEndDecelerating = handler }
    }

    @discardableResult
    public func didEndDecelerating(handler: @escaping () -> Void) -> Self {
        didEndDecelerating { _ in handler() }
    }

    // MARK: -

    @discardableResult
    public func didEndScrollingAnimation(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didEndScrollingAnimation = handler }
    }

    @discardableResult
    public func didEndScrollingAnimation(handler: @escaping () -> Void) -> Self {
        didEndScrollingAnimation { _ in handler() }
    }

    // MARK: -

    @discardableResult
    public func viewForZooming(handler: @escaping (Self) -> UIView?) -> Self {
        updateObserver { $0.viewForZooming = handler }
    }

    @discardableResult
    public func viewForZooming(handler: @escaping () -> UIView?) -> Self {
        viewForZooming { _ in handler() }
    }

    // MARK: -

    @discardableResult
    public func willBeginZooming(handler: @escaping (Self, UIView?) -> Void) -> Self {
        updateObserver { $0.willBeginZooming = handler }
    }

    @discardableResult
    public func willBeginZooming(handler: @escaping (UIView?) -> Void) -> Self {
        willBeginZooming { handler($1) }
    }

    // MARK: -

    @discardableResult
    public func didEndZooming(handler: @escaping (Self, UIView?, CGFloat) -> Void) -> Self {
        updateObserver { $0.didEndZooming = handler }
    }

    @discardableResult
    public func didEndZooming(handler: @escaping (UIView?, CGFloat) -> Void) -> Self {
        didEndZooming { handler($1, $2) }
    }

    // MARK: -

    @discardableResult
    public func shouldScrollToTop(handler: @escaping (Self) -> Bool) -> Self {
        updateObserver { $0.shouldScrollToTop = handler }
    }

    @discardableResult
    public func shouldScrollToTop(handler: @escaping () -> Bool) -> Self {
        shouldScrollToTop { _ in handler() }
    }

    // MARK: -

    @discardableResult
    public func didScrollToTop(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didScrollToTop = handler }
    }

    @discardableResult
    public func didScrollToTop(handler: @escaping () -> Void) -> Self {
        didScrollToTop { _ in handler() }
    }

    // MARK: -

    @discardableResult
    public func didChangeAdjustedContentInset(handler: @escaping (Self) -> Void) -> Self {
        updateObserver { $0.didChangeAdjustedContentInset = handler }
    }

    @discardableResult
    public func didChangeAdjustedContentInset(handler: @escaping () -> Void) -> Self {
        didChangeAdjustedContentInset { _ in handler() }
    }

    // MARK: -

    private func updateObserver(_ update: (ScrollViewObserver<Self>) -> Void) -> Self {
        if let scrollViewObserver = observer as? ScrollViewObserver<Self> {
            update(scrollViewObserver)
        } else {
            let scrollViewObserver = ScrollViewObserver(scrollView: self)
            update(scrollViewObserver)
            observer = scrollViewObserver
        }
        return self
    }
}

private final class ScrollViewObserver<T: UIScrollView>: NSObject, UIScrollViewDelegate {

    var didScroll: ((T) -> Void)?
    var didZoom: ((T) -> Void)?
    var willBeginDragging: ((T) -> Void)?
    var willEndDragging: ((T, _ velociry: CGPoint, _ targetContentOffset: UnsafeMutablePointer<CGPoint>) -> Void)?
    var didEndDragging: ((T, _ decelerate: Bool) -> Void)?
    var willBeginDecelerating: ((T) -> Void)?
    var didEndDecelerating: ((T) -> Void)?
    var didEndScrollingAnimation: ((T) -> Void)?
    var viewForZooming: ((T) -> UIView?)?
    var willBeginZooming: ((T, _ view: UIView?) -> Void)?
    var didEndZooming: ((T, _ view: UIView?, _ scale: CGFloat) -> Void)?
    var shouldScrollToTop: ((T) -> Bool)?
    var didScrollToTop: ((T) -> Void)?
    var didChangeAdjustedContentInset: ((T) -> Void)?

    init(scrollView: T) {
        super.init()
        scrollView.delegate = self
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let scrollView = scrollView as? T, let didScroll = didScroll else {
            return
        }

        didScroll(scrollView)
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        guard let scrollView = scrollView as? T, let didZoom = didZoom else {
            return
        }

        didZoom(scrollView)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let scrollView = scrollView as? T, let willBeginDragging = willBeginDragging else {
            return
        }

        willBeginDragging(scrollView)
    }

    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        guard let scrollView = scrollView as? T, let willEndDragging = willEndDragging else {
            return
        }

        willEndDragging(scrollView, velocity, targetContentOffset)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard let scrollView = scrollView as? T, let didEndDragging = didEndDragging else {
            return
        }

        didEndDragging(scrollView, decelerate)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        guard let scrollView = scrollView as? T, let willBeginDecelerating = willBeginDecelerating else {
            return
        }

        willBeginDecelerating(scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let scrollView = scrollView as? T, let didEndDecelerating = didEndDecelerating else {
            return
        }

        didEndDecelerating(scrollView)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard let scrollView = scrollView as? T, let didEndScrollingAnimation = didEndScrollingAnimation else {
            return
        }

        didEndScrollingAnimation(scrollView)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        guard let scrollView = scrollView as? T, let viewForZooming = viewForZooming else {
            return nil
        }

        return viewForZooming(scrollView)
    }

    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        guard let scrollView = scrollView as? T, let willBeginZooming = willBeginZooming else {
            return
        }

        willBeginZooming(scrollView, view)
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        guard let scrollView = scrollView as? T, let didEndZooming = didEndZooming else {
            return
        }

        didEndZooming(scrollView, view, scale)
    }

    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        guard let scrollView = scrollView as? T, let shouldScrollToTop = shouldScrollToTop else {
            return true
        }

        return shouldScrollToTop(scrollView)
    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        guard let scrollView = scrollView as? T, let didScrollToTop = didScrollToTop else {
            return
        }

        didScrollToTop(scrollView)
    }

    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        guard let scrollView = scrollView as? T,
              let didChangeAdjustedContentInset = didChangeAdjustedContentInset else {
            return
        }

        didChangeAdjustedContentInset(scrollView)
    }
}

#endif
