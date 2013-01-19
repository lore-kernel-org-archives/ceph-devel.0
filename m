From: Yehuda Sadeh <yehuda@inktank.com>
Subject: rgw geo-replication and disaster recovery
Date: Fri, 18 Jan 2013 16:09:41 -0800
Message-ID: <CAC-hyiFpYTvLJUhE3EPk9VbNXgA3YShwQjK9Bny7jBPtg9_1SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33762 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473Ab3ASAJm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 19:09:42 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so6957964iea.7
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 16:09:41 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently it is assumed that ceph clusters are concentrated in a
single geographical location. Thus, the rados gateway, which leverages
the ceph object storage (RADOS) for its backend store is limited to a
single location. There are two main issues that we would like to
solve:

 - Disaster Recovery

The ability to have a solution for disaster scenarios.

 - Different Geographical Locations

This has two advantages: one is the fact that data can be located in
distinct locations, which reduces the risk of losing all data due to
unfortunate events. It also enables users to store data closer to
where they are located, which can mean faster and better service.

The following describes these features and their implementation.
Comments and questions are welcome as always.

Yehuda


Terminology
============

 - zone

A unique set of pools within a single Ceph cluster.

 - region

A set of one or more zones

 - master region

The root region, the one where user metadata modifications take place in

 - master zone

The primary zone in a region, where all writes go into.

 - backup/slave zone

A zone which asynchronously receives copies of buckets from the master zone.


Description
============

In a geographically disperse object storage system, data may be put in
buckets that are located in different regions. A bucket is created in
a specific region, and all data created under this bucket (as in
objects) will reside in that region.
Users can create buckets in any of the regions, and user's list of
buckets will not be tied to a specific region. User's metadata (that
also includes buckets' list) will be maintained in a single region and
will be replicated to all the regions.

Different zones within a specific logical region will be used for
disaster recovery. Data will be replicated from the master zone to the
backup zones in an asynchronous way.

Each zone contains the user metadata pool(s) and one or more data
pool. Each rgw instance controls a single zone instance. There can be
multiple rgw instances per zone.

Multi tenancy can be achieved within a single ceph cluster by defining
different set of metadata and data pools.

A region map will describe the different regions and zones that form
these regions.

region:
 - name
 - list of zones within the region
 - master zone name
 - status (master / regular) [whether controls user metadata]

zone:
 - name
 - endpoint URL(s)
 - status (master / slave)

The region map will be configured by the admin, and will be installed
on all zones. Roles changes (e.g., moving a zone from a master to
slave role) will be achieved by updating the region map.

Bucket metadata now also includes the region where this bucket
resides. When a bucket is created on any region other than the master
region, the creation request will be forwarded to the master region.

Metadata will be replicated from the master region (not zone) to the
other regions.

New radosgw-admin commands will allow configuring and retrieving the region map.

RESTful APIs
=================

A set of RESTful APIs will be defined to implement the geo-replation
and disaster recovery features. The APIs will expose the newly
developed functionality that will be implemented. Zones will interact
only using the RESTful API via their defined endpoints.

Operations like copy object will now need to handle the case of
reading/writing from/to a different region. A new 'service' user
role/cap will be added and will allow one rgw instance to interact
with another.


User Metadata Replication
-------------------------------------

User metadata is naturally updated less frequently than user data.
User metadata will be modified only on the designated master region.
Any user metadata change will be synchronously written to a
metadata-changes log. Log will contain list of changes indexed by a
change id that will increase monotonically. Log will be striped across
multiple log objects, each will have its own unique id.
A remote site that fetches changes will specify the different log
versions it had last seen (if any). The returned response will be a
list of changes and the corresponding log ids and log versions for
each change.

Change records will consist of:
 - log id
 - log version
 - resource type (user / bucket)
 - resource operation + specific operation data (e.g., bucket created,
user key removed, etc.)

Log operations should be idempotent.

A set of RESTful admin API requests will allow requesting the complete
list of users and their corresponding metadata.

New API will consist of the following:
 - a request to list all existing users
 - a request to retrieve user info + list of buckets for requested
users / all users
 - a request to retrieve list of changes since specific logs version
 - a request to retrieve current logs version

First synchronization of user metadata to the remote region will be
done as follows:
 - read logs versions
 - retrieve user info for all users, apply locally
 - read any new changes and apply them

A metadata replication agent will run on the remote master zones, and
on the slave zones. The master zones will follow the master zone on
the master region. The slave zones will follow their own master zones.
The replication agent will periodically query for new changes and
apply them locally.



Disaster Recovery Implementation
=========================

The following discusses a disaster recovery implementation.

* Master, backup zones

A backup (slave) zone follows a master zone. It is intended that
clients will only be accessing the master zone. Read only access
to the slave will be possible, however, data in the slave may
be outdated. It is possible to switch master and backup settings
of a zone.

The idea is to have a primary zone, and one or more backup
zones following it. Updates will be logged per bucket on the
primary, and list of modified buckets will also be logged.
Backup zones will poll the list of modified buckets, and will then retrieve
the changes per bucket. Changes will be applied on the backup zone.

As stated, this is a disaster recovery solution, and comes to provide
safety net for complete data loss. The solution does not provide a
complete data loss protection, as latest data that has not been
transferred to the slaves may be lost.

Master
-------

Bucket index log
^^^^^^^^^^^^^^^^

The 'bucket index log' will keep track of modifications made in the
bucket (objects uploaded, deleted, modified).

The following modifications will be made to the bucket index:

* bucket index version

The bucket index will keep an index version that will increase monotonically.

* log every modify operation

The bucket index will now log every modify operation. An additional
index version entry will be added to each object entry in the bucket
index.

* list objects objclass operation returns more info

list objects objclass operation will also return last index version,
as well as the version of each object (the bucket index version when
it was created). This will allow radosgw to retrieve the entire list
of objects in a bucket in parts, and then retrieve all the changes
that happened since starting the operation. It is required so that we
could do a full sync of the bucket index.

* operation to retrieve bucket index log entries

A new objclass operation will retrieve bucket log index entries. It
will get a starting event number, max entries.
When requested with a

*  operation to trim bucket index log entries

A new objclass operation to remove bucket log index entries. It will
get a starting event number (0 - start from the beginning), last event
number. It will not be able to remove more than predefined number of
entries.

A new set of RESTful API calls will be implemented within rgw and will
export the new bucket index log functionality.


Updated Buckets Log
^^^^^^^^^^^^^^^^^^^

A log that contains the list of modified buckets within a specific
period.  Log info may be spread across multiple objects. This will be
done similarly to what we did with the usage info, and with the
garbage collection. Each bucket's data will go to a specific log
object (by hashing bucket name, modulo number of objects).
The log will use omap to index entries by timestamp, and by a log id
(monotonically increasing) and
will be implemented as an objclass.


* log resolution

We'll define a log resolution period. In order to avoid sending extra
write for updating this log
for every modifications, we'll define a time length for which a
log entry is valid. Any update that completes within that will only be
reported once in the log.

A bucket modification operation will not be allowed to complete before
a log entry (with the bucket name) was appended to the bucket
operations log within the past ttl (the cycle in which the operation
completes). That means that the first write/modification to that
bucket will have to send an append request. All bucket modification
operations that happen before its completion (and within the same log
cycle) will have to wait for it.

The radosgw will hold a list of all the buckets that were updated in
the past two cycles
(within the specific instance) and every cycle will log these entries
in the updated buckets log.


Backup (Slave)
---------

* Bucket index log

The bucket index log will also hold the last master version.

* Processing state

The sync processing state will be kept in a log. This will include
latest updated buckets log id that was processed successfully.

* Full sync info

A list that contains the names of the buckets that require a full
sync. It will also be spread across multiple objects.

Full Sync of System
^^^^^^^^^^^^^^^^^^^

Does the following::

 - retrieve list of all buckets, update the full sync buckets list,
start processing

Processing a single 'full sync list' object::

 - if successfully locked object then:
 - (periodically, potentially in a different thread) renew lock
 - for each bucket
   - list objects (keep bucket index version retrieved on the first
request to list objects).
     - for each object we get object name, version (bucket version), tag
   - read objects from master (*), write them to local (slave) cluster
(keep object tag)
   - when done, update local bucket index with the bucket index
version retrieved from master
 - unlock object

(*) we should decide what to do in the case of tag mismatch

Continuous Update
^^^^^^^^^^^^^^^^^

A process that does the following::

 - Try to set a lock on a updated buckets log
 - if succeeded then:
    - read next log entries (but never read entries newer than current
time - updated buckets log ttl)
    - for each bucket in log:
      - fetch bucket index version from local (secondary) bucket index
      - request a list of changes from remote (primary) bucket index,
starting at the local bucket index version
      - if successful (remote had the requested data)
        - update local data
      - if not successful
        - add bucket to list of buckets requiring full sync
      - renew lock until done, then release lock
 - continue with the next log entry

We still need to be able to fully sync buckets that need to catch-up.
So also do the following (in parallel)::

 - For each object in full sync list
 - periodically check list of buckets requiring full sync
 - if not empty:
   - for each bucket: full sync bucket (as specified above), remove
bucket from list


Replication Agent
^^^^^^^^^^^^^^^^^^

The replication agent will be a new software that will be used to
manage handling the bucket synchronization from the master zone to the
slave zone. The replication agent will read the changes on the master
zone, and will apply them on the slave zones. It is possible that the
replication agent will not read/write any actual user data, but rather
send a copy command to the slave rgw instance. Note that the
replication agent will use the newly RESTful API calls and will not
use rados calls directly.
