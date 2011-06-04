## For more detial please see
## http://www.cs.wisc.edu/condor/manual/v7.4/3_3Configuration.html


##  What machine is your central manager?

#CONDOR_HOST = $(FULL_HOSTNAME)

## Pool's short description

COLLECTOR_NAME = Personal Condor at $(FULL_HOSTNAME)

##  When is this machine willing to start a job? 

START = TRUE


##  When to suspend a job?

SUSPEND = FALSE


##  When to nicely stop a job?
##  (as opposed to killing it instantaneously)

PREEMPT = FALSE


##  When to instantaneously kill a preempting job
##  (e.g. if a job is in the pre-empting stage for too long)

KILL = FALSE

##  This macro determines what daemons the condor_master will start and keep its watchful eyes on.
##  The list is a comma or space separated list of subsystem names

DAEMON_LIST= COLLECTOR, MASTER, NEGOTIATOR

##  Sets how often the condor_negotiator starts a negotiation cycle. 
##  It is defined in seconds and defaults to 60 (1 minute). 

NEGOTIATOR_INTERVAL = 20

##  Disable UID_DOMAIN check when submit a job

TRUST_UID_DOMAIN = TRUE

