From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: RGW metadata search update
Date: Thu, 6 Apr 2017 17:34:26 -0700
Message-ID: <CADRKj5RNkh7y0qrxdW-f0-21Oa8C6Wz6KSf0qabjs8ROg+zgLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33572 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbdDGAe3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Apr 2017 20:34:29 -0400
Received: by mail-qt0-f174.google.com with SMTP id i34so50042975qtc.0
        for <ceph-devel@vger.kernel.org>; Thu, 06 Apr 2017 17:34:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Some time ago I sent a description of the RGW metadata search feature
that was implemented prior to Kraken. The feature itself was
functional, but there were quite a few open questions and we didn't
regard it as complete. Here's a reformatted version of that email:

http://ceph.com/geen-categorie/rgw-metadata-search/


The gist of it is as follows. As part of the RGW multisite system, we
introduced a way to create new tier types. Originally a single RGW
zonegroup would include multiple zones, each mirroring each other.
With the new sync modules system we can now make it so that a copy of
the data can be sent to a different data tier. Enters Elasticsearch,
that can be used to index the metadata of objects in a zonegroup. So
now we can have multiple zones in a single zonegroup where one (or
more) of the zones indexes the objects' metadata, instead of storing
the data in rados.
For example, we can create a zonegroup that would have 3 zones: zone
A, zone B, and zone M. Zone A, and Zone B are data zones. Users will
create buckets there, and upload objects to them. Zone M will be a
metadata search zone. The data that will be written in A, and B will
be indexed and users could query information about it when accessing
zone M.

One of the main question I had at the time was whether we should
involve RGW with the search queries, or should that be left for the
users to deal with, accessing Elasticsearch directly. We came to the
conclusion that it would be much better in terms of user experience if
we served as a proxy between the users and Elasticsearch and manage
the queries ourselves. This allows us to provide a better experience,
and while at it also solves the authentication and authorization
problems. End users do not have access to Elasticsearch, and we make
sure that the queries that are sent to Elasticsearch request for data
that the users are permitted to read.

I've been working on implementing the new RGW capabilities that allows
it to be used for querying Elasticsearch. There are other changes that
were added, which I will describe as well. The code is still pending
review and testing, and can be found here:

https://github.com/ceph/ceph/pull/14351


 - What's new and how to configure?

Follows is a list of the few new APIs. and new configurables.
Configuration example below.

1. New RESTful APIs were added to RGW, in order to use and control
metadata search:

* Query metadata

The request needs to be sent to RGW that is located on the
elasticsearch tier zone.

Input:

GET /[<bucket>]?query=<expression>

request params:
 - max-keys: max number of entries to return
 - marker: pagination marker


expression := [(]<arg> <op> <value> [)][<and|or> ...]

op is one of the following:
<, <=, ==, >=, >

For example:

GET /?query=name==foo

Will return all the indexed keys that user has read permission to, and
are named 'foo'.

The output will be a list of keys in XML that is similar to the S3
list buckets response.


* Configure custom metadata fields

Define which custom metadata entries should be indexed (under the
specified bucket), and what are the types of these keys. If explicit
custom metadata indexing is configured, this is needed so that rgw
will index the specified custom metadata values. Otherwise it is
needed in cases where the indexed metadata keys are of a type other
than string.

Note: Currently this request should be sent to the metadata master zone.

Input:

PUT /<bucket>?mdsearch

HTTP headers:
A-Amz-Meta-Search: <key [; type]> [, ...]

Where key is x-amz-meta-<name>, and type is one of the following:
string, integer, date.


* Delete custom metadata configuration

Delete custom metadata bucket configuration.

Note: Currently this request should be sent to the metadata master zone.

Input:

DELETE /<bucket>?mdsearch


* Get custom metadata configuration

Retrieve custom metadata bucket configuration.

Input:

GET /<bucket>?mdsearch


2. Elasticsearch tier zone configurables

The following configurables are now defined:

* endpoint

Specifies the Elasticsearch server endpoint to access


* num_shards (integer)

The number of shards that Elasticsearch will be configured with on
data sync initialization. Note that this cannot be changed after init.
Any change here requires rebuild of the Elasticsearch index and reinit
of the data sync process.


* num_replicas (integer)

The number of the replicas that Elasticsearch will be configured with
on data sync initialization.


* explicit_custom_meta (true | false)

Specifies whether all user custom metadata will be indexed, or whether
user will need to configure (at the bucket level) what custome
metadata entries should be indexed. This is false by default


* index_buckets_list (comma separated list of strings)

If empty, all buckets will be indexed. Otherwise, only buckets
specified here will be indexed. It is possible to provide bucket
prefixes (e.g., foo*), or bucket suffixes (e.g., *bar).


* approved_owners_list (comma separated list of strings)

If empty, buckets of all owners will be indexed (subject to other
restrictions), otherwise, only buckets owned by specified owners will
be indexed. Suffixes and prefixes can also be provided.


* override_index_path (string)

if not empty, this string will be used as the elasticsearch index
path. Otherwise the index path will be determined and generated on
sync initialization.


3. Configuration example

(the following instructions are based on the multi-site configuration document)

We'll have a simple configuration in which we'd create a new realm,
with a single zonegroup, and have two zones in that zonegroup: a data
zone, and a metadata search zone. Both zones will run on the same ceph
cluster.

* Naming

realm: gold
zonegroup: us
data zone: us-east-1
metadata search zone: us-east-es

* Prerequisites

 - ceph cluster
 - elasticsearch configured, we'll assume it runs on the same machine
as radosgw, listening to default port 9200


* System Keys

Similar to a regular multisite configuration, we'll need to define
system keys for cross radosgw communications:

$ SYSTEM_ACCESS_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w
20 | head -n 1)
$ SYSTEM_SECRET_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w
40 | head -n 1)

$ RGW_HOST=<host>

* Create a realm


$ radosgw-admin realm create --rgw-realm=gold --default


* Remove default zone (not necessarily needed, only if default zone
was generated)

radosgw-admin zonegroup delete --rgw-zonegroup=default


* Create zonegroup

$ radosgw-admin zonegroup create --rgw-zonegroup=us
--endpoints=http://${RGW_HOST}:8000 --master --default
{
    "id": "db23c836-9184-4090-a6dc-8bb0489c72ba",
    "name": "us",
    "api_name": "us",
    "is_master": "true",
    "endpoints": [
        "http:\/\/<RGW_HOST>:8000"
    ],
    "hostnames": [],
    "hostnames_s3website": [],
    "master_zone": "",
    "zones": [],
    "placement_targets": [],
    "default_placement": "",
    "realm_id": "0fea4ced-14fb-436d-8a4d-3d362adcf4e1"
}


* Create zone

$ radosgw-admin zone create --rgw-zonegroup=us --rgw-zone=us-east-1
--endpoints=http://${RGW_HOST}:8000 --access-key=$SYSTEM_ACCESS_KEY
--secret=$SYSTEM_SECRET_KEY --default --master
{
    "id": "a9b9e45a-4fa6-49e8-9236-db31e84169b8",
    "name": "us-east-1",
    "domain_root": "us-east-1.rgw.meta:root",
    "control_pool": "us-east-1.rgw.control",
    "gc_pool": "us-east-1.rgw.log:gc",
    "lc_pool": "us-east-1.rgw.log:lc",
    "log_pool": "us-east-1.rgw.log",
    "intent_log_pool": "us-east-1.rgw.log:intent",
    "usage_log_pool": "us-east-1.rgw.log:usage",
    "user_keys_pool": "us-east-1.rgw.meta:users.keys",
    "user_email_pool": "us-east-1.rgw.meta:users.email",
    "user_swift_pool": "us-east-1.rgw.meta:users.swift",
    "user_uid_pool": "us-east-1.rgw.meta:users.uid",
    "system_key": {
        "access_key": "NgKnw4Q9ocFUJUykxHiu",
        "secret_key": "QahZhmhRg12oiKOq1bVsO6qO43Yqd8OMu8jrwVSq"
    },
    "placement_pools": [
        {
            "key": "default-placement",
            "val": {
                "index_pool": "us-east-1.rgw.buckets.index",
                "data_pool": "us-east-1.rgw.buckets.data",
                "data_extra_pool": "us-east-1.rgw.buckets.non-ec",
                "index_type": 0,
                "compression": ""
            }
        }
    ],
    "metadata_heap": "",
    "tier_config": [],
    "realm_id": "0fea4ced-14fb-436d-8a4d-3d362adcf4e1"
}


* Create system user

* radosgw-admin user create --uid=zone.user --display-name="Zone User"
--access-key=$SYSTEM_ACCESS_KEY --secret=$SYSTEM_SECRET_KEY --system
{
    "user_id": "zone.user",
    "display_name": "Zone User",
    "email": "",
    "suspended": 0,
    "max_buckets": 1000,
    "auid": 0,
    "subusers": [],
    "keys": [
        {
            "user": "zone.user",
            "access_key": "NgKnw4Q9ocFUJUykxHiu",
            "secret_key": "QahZhmhRg12oiKOq1bVsO6qO43Yqd8OMu8jrwVSq"
        }
    ],
    "swift_keys": [],
    "caps": [],
    "op_mask": "read, write, delete",
    "system": "true",
    "default_placement": "",
    "placement_tags": [],
    "bucket_quota": {
        "enabled": false,
        "check_on_raw": false,
        "max_size": -1,
        "max_size_kb": 0,
        "max_objects": -1
    },
    "user_quota": {
        "enabled": false,
        "check_on_raw": false,
        "max_size": -1,
        "max_size_kb": 0,
        "max_objects": -1
    },
    "temp_url_keys": [],
    "type": "rgw"
}

* Update the period

$ radosgw-admin period update --commit

{
    "id": "96535dc9-cb15-4c3d-96a1-d661a2f6e71f",
    "epoch": 1,
    "predecessor_uuid": "691ebbf4-7104-4c78-aa42-7d20061e31ff",
    "sync_status": [
...
    "realm_id": "0fea4ced-14fb-436d-8a4d-3d362adcf4e1",
    "realm_name": "gold",
    "realm_epoch": 2
}


* Start radosgw

<this step varies, depending on the specific OS and env>

One way to do it:

$ radosgw --rgw-frontends="civetweb port=8000"
--log-file=/var/log/ceph/radosgw-us-east-1.log


* Configure second zone in the same cluster, used for metadata indexing

$ radosgw-admin zone create --rgw-zonegroup=us --rgw-zone=us-east-es
--access-key=$SYSTEM_ACCESS_KEY --secret=$SYSTEM_SECRET_KEY
--endpoints=http://${RGW_HOST}:8002
{
    "id": "24b0a61c-8a99-4f30-9bce-a99900dba818",
    "name": "us-east-es",
    "domain_root": "us-east-es.rgw.meta:root",
    "control_pool": "us-east-es.rgw.control",
    "gc_pool": "us-east-es.rgw.log:gc",
    "lc_pool": "us-east-es.rgw.log:lc",
    "log_pool": "us-east-es.rgw.log",
    "intent_log_pool": "us-east-es.rgw.log:intent",
    "usage_log_pool": "us-east-es.rgw.log:usage",
    "user_keys_pool": "us-east-es.rgw.meta:users.keys",
    "user_email_pool": "us-east-es.rgw.meta:users.email",
    "user_swift_pool": "us-east-es.rgw.meta:users.swift",
    "user_uid_pool": "us-east-es.rgw.meta:users.uid",
    "system_key": {
        "access_key": "NgKnw4Q9ocFUJUykxHiu",
        "secret_key": "QahZhmhRg12oiKOq1bVsO6qO43Yqd8OMu8jrwVSq"
    },
    "placement_pools": [
        {
            "key": "default-placement",
            "val": {
                "index_pool": "us-east-es.rgw.buckets.index",
                "data_pool": "us-east-es.rgw.buckets.data",
                "data_extra_pool": "us-east-es.rgw.buckets.non-ec",
                "index_type": 0,
                "compression": ""
            }
        }
    ],
    "metadata_heap": "",
    "tier_config": [],
    "realm_id": "0fea4ced-14fb-436d-8a4d-3d362adcf4e1"
}

* Elasticsearch related zone configuration

$ radosgw-admin zone modify --rgw-zone=us-east-es
--tier-type=elasticsearch
--tier-config=endpoint=http://localhost:9200,num_shards=10,num_replicas=1
{
    "id": "24b0a61c-8a99-4f30-9bce-a99900dba818",
    "name": "us-east-es"
...
    "tier_config": [
        {
            "key": "endpoint",
            "val": "http:\/\/localhost:9200"
        },
        {
            "key": "num_replicas",
            "val": "1"
        },
        {
            "key": "num_shards",
            "val": "10"
        }
    ],
    "realm_id": "0fea4ced-14fb-436d-8a4d-3d362adcf4e1"
}

* Update period

$ radosgw-admin period update --commit
...


* Start second radosgw

<this step varies, as with the first radosgw>


One way to do it:

$ radosgw --rgw-zone=us-east-es --rgw-frontends="civetweb port=8002"
--log-file=/var/log/ceph/radosgw-us-east-es.log


* Create a user, upload stuff

$ radosgw-admin user create --uid=yehsad --display-name=yehuda
...

I'm using the obo tool (can be found here:
https://github.com/yehudasa/obo) to create buckets and upload some
data:

$ export S3_ACCESS_KEY_ID=...
$ export S3_SECRET_ACCESS_KEY=...
$ export S3_HOSTNAME=$RGW_HOST:8000

$ obo create buck
$ obo put buck/foo --in-file=foo
$ obo put buck/foo1 --in-file=foo

* Query metadata

I implemented a metadata search operation in obo, and it can be used as follows:

First, make sure we point obo at the correct radosgw:
$ export S3_HOSTNAME=$RGW_HOST:8002

$ obo mdsearch buck --query='name>=foo1'
{
    "SearchMetadataResponse": {
        "Marker": {},
        "IsTruncated": "false",
        "Contents": [
            {
                "Bucket": "buck",
                "Key": "foo2",
                "Instance": "null",
                "LastModified": "2017-04-06T23:18:39.053Z",
                "ETag": "\"7748956db0bddb51a2bb81a26395ff98\"",
                "Owner": {
                    "ID": "yehsad",
                    "DisplayName": "yehuda"
                },
                "CustomMetadata": {}
            },
            {
                "Bucket": "buck",
                "Key": "foo1",
                "Instance": "null",
                "LastModified": "2017-04-06T23:18:15.029Z",
                "ETag": "\"7748956db0bddb51a2bb81a26395ff98\"",
                "Owner": {
                    "ID": "yehsad",
                    "DisplayName": "yehuda"
                },
                "CustomMetadata": {}
            }
        ]
    }
}

$ Configure custom metadata

By default we don't index any custom metadata. We can turn on custom
metadata indexing on a bucket by the following obo command:

$ obo mdsearch buck --config='x-amz-meta-foo; string, x-amz-meta-bar; integer'

Note that this will only apply to new data (indexing old data will
require re-initializing the sync process on the specific bucket).

$ Query metadata again

Upload a few more objects, this time with custom metadata:

$  obo put buck/foo3 --in-file=LICENSE --x-amz-meta foo=abc bar=12
$  obo put buck/foo4 --in-file=LICENSE --x-amz-meta foo=bbb bar=8
$  obo put buck/foo2 --in-file=LICENSE --x-amz-meta foo=aaa

and we can run the following query:

$ obo mdsearch buck --query='x-amz-meta-foo==aaa or x-amz-meta-bar < 12'
{
    "SearchMetadataResponse": {
        "Marker": {},
        "IsTruncated": "false",
        "Contents": [
            {
                "Bucket": "buck",
                "Key": "foo4",
                "Instance": "null",
                "LastModified": "2017-04-07T00:04:15.584Z",
                "ETag": "\"7748956db0bddb51a2bb81a26395ff98\"",
                "Owner": {
                    "ID": "yehsad",
                    "DisplayName": "yehuda"
                },
                "CustomMetadata": {
                    "Entry": [
                        {
                            "Name": "foo",
                            "Value": "bbb"
                        },
                        {
                            "Name": "bar",
                            "Value": "8"
                        }
                    ]
                }
            },
            {
                "Bucket": "buck",
                "Key": "foo2",
                "Instance": "null",
                "LastModified": "2017-04-07T00:05:00.666Z",
                "ETag": "\"7748956db0bddb51a2bb81a26395ff98\"",
                "Owner": {
                    "ID": "yehsad",
                    "DisplayName": "yehuda"
                },
                "CustomMetadata": {
                    "Entry": {
                        "Name": "foo",
                        "Value": "aaa"
                    }
                }
            }
        ]
    }
}


That's pretty much it. I'll probably edit this email and put it where
it needs to be under ceph/doc. I identified a few issues when working
on this document, and I'm sure there are many more. My next planned
task is to create a testing tool for it. Please let me know if you
have any questions or comments. We're planning to get this merged in
for Luminous.

Yehuda
