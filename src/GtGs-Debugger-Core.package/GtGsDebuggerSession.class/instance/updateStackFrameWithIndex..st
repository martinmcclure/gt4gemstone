as yet unclassified
updateStackFrameWithIndex: anInteger
	| targetStackFrame |
	targetStackFrame := (self stack frames at: anInteger).
	targetStackFrame updateCacheFull.
	^ self topezServer objectSerializer toString: targetStackFrame 