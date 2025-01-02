package models

type EventType string

const (
	Workshop  EventType = "WORKSHOP"
	Cultural  EventType = "CULTURAL"
	Sports    EventType = "SPORTS"
	Social    EventType = "SOCIAL"
	Community EventType = "COMMUNITY"
	Charity   EventType = "CHARITY"
	Party     EventType = "PARTY"
)

var EventTypes = []string{string(Workshop), string(Cultural), string(Sports), string(Social), string(Community), string(Charity), string(Party)}

type ParticipationStatus string

const (
	Interested      ParticipationStatus = "INTERESTED"
	WillParticipate ParticipationStatus = "WILL_PARTICIPATE"
	NotInterested   ParticipationStatus = "NOT_INTERESTED"
)

var ParticipationStatuses = []ParticipationStatus{Interested, WillParticipate, NotInterested}

type VoteType string

const (
	SingleVote    VoteType = "SINGLE_CHOICE"
	MultipleVotes VoteType = "MULTIPLE_CHOICE"
)

type VoteChangeType string

const (
	CanChangeVote    VoteChangeType = "CAN_CHANGE_VOTE"
	CannotChangeVote VoteChangeType = "CANNOT_CHANGE_VOTE"
)

type QuestionType string

const (
	Toggle         QuestionType = "TOGGLE"
	SingleChoice   QuestionType = "SINGLE_CHOICE"
	MultipleChoice QuestionType = "MULTIPLE_CHOICE"
)
