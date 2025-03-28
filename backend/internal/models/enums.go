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
	NotApplicable   ParticipationStatus = "NOT_APPLICABLE"
)

var ParticipationStatuses = []ParticipationStatus{Interested, WillParticipate, NotInterested}

type VoteType string

const (
	CanChangeVote    VoteType = "CAN_CHANGE_VOTE"
	CannotChangeVote VoteType = "CANNOT_CHANGE_VOTE"
)

var VoteTypes = []VoteType{CanChangeVote, CannotChangeVote}

type QuestionType string

const (
	Toggle         QuestionType = "TOGGLE"
	SingleChoice   QuestionType = "SINGLE_CHOICE"
	MultipleChoice QuestionType = "MULTIPLE_CHOICE"
)
