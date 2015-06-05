From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: new rgw multi-site design
Date: Fri, 5 Jun 2015 18:09:31 -0400 (EDT)
Message-ID: <1462876392.10606653.1433542171136.JavaMail.zimbra@redhat.com>
References: <484976066.10603304.1433541449706.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:35207 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbFEWJb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jun 2015 18:09:31 -0400
Received: from zmail23.collab.prod.int.phx2.redhat.com (zmail23.collab.prod.int.phx2.redhat.com [10.5.83.28])
	by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t55M9VkI015673
	for <ceph-devel@vger.kernel.org>; Fri, 5 Jun 2015 18:09:31 -0400
In-Reply-To: <484976066.10603304.1433541449706.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

We discussed revamping the rgw multi site feature. This includes both simplifying the whole configuration process, and reimplementing the whole process. Also, it will support active-active zone configuration, so multiple zones within the same zonegroup (formerly known as 'region') will be writable. The following discusses the configuration changes, and the implementation details that we discussed recently.

1. Configuration Changes
1.1. Zonegroup map

The zonegroup map holds a map of the entire system, and certain configurables for the different zonegroups and zones. It holds the relationships between the different zonegroups and other configuartion:

For the entire map
 - which zonegroup is the master

For each zonegroup
 - access url[s]
 - existing storage policies
 
For each zone
 - id, name
 - access url[s]
 - peers

In the new configuration scheme, the master zonegroup will be in control of the zonegroup map. In order to make a change to the system configuration, a command will be sent to the url of the master zonegroup, and the new configuration will propagate to the rest of the system. rgw will be able to handle dynamic changes to the zonegroup and zone configuration.
There will be one zone that will be designated as the master in the master zonegroup, and will manage all user and bucket creation.

zonegroup map will have a version epoch that will increment after every change.

1.2. Defining a new zonegroup

Currently, in order to define a new zonegroup, we need to inject a json that holds the zonegroup configuration, then we need to update the zonegroupmap, and then we need to distribute that zonegroupmap into all existing zonegroups and restart all rgws for that to take effect. I don't think this is a good scheme.

A zonegroup will have a zonegroup id, and a zonegroup name. For backward compatibility, older zonegroups will have their zonegroup_id equal to their name.

When setting up a new zonegroup, we'll need to specify an entry point for the 'master' zonegroup. That zonegroup will be in control of the zonegroupmap, and it will distribute the zonegroupmap updates to all zones.

If the zonegroup that we set up is the first zonegroup, we'll need to specify it in the command line. We won't be able to set up a secondary zonegroups if the master has not been specified.

1.3. Defining a new zone

Currently, when running an rgw it does the following:

Read the rgw_zone configurable, check the root pool for the configuration of this zone. If rgw_zone is not defined it will read the default zone name out of the
it will create the 'default' zone, and assign it as the default.

Once a zone name has been set, it cannot really be changed. The zone names are embedded in the rados object names that are created to hold the actual rgw objects.

In order to support zone renaming, and more dynamic configuration we should create a logical 'zone id' that the zone name will point at. The zone id will be a string. When creating a new zone it will be auto generated, and will not be modified. For backward compatibility, older zones will have a zone_id that will match their zone name.

To set up a new zone, the rgw command will include the url to the master zonegroup, and keys to access it. It will also include the name of the zonegroup this zone should reside in. If this zonegroup does not exist, it will be created (if appropriate param was passed in). The master zonegroup will create a new system user for this specific zone, and will send it back.

When a new zone starts up, we'll auto-create all the rados pools that it will use. It will first need to determine whether pools already exist, and are already assigned to a different zone. The naming scheme for the pools would be something like:

.{zone_id}-x-{pool-name}

1.4. Dynamic zonegroup and zone changes

rgw will be able to identify changes to the zonegroupmap, and to the zone configuration. This will be done by the following:

rgw will be able to restart itself with a new rados backend handler (RGWRados) after detecting that a configuration change has been made. It will finish handling existing requests, but restart all the frontend handlers with the new RGWRados config.
rgw will set a specific watch/notify handler that will be used to getting updates about the zonegroupmap configuration.
Upon receiving a change, the master zonegroup zone will send a message to all the different zonegroups about the new configuration change.

Any synchronization activity will be dynamically re-set according to the new configuration.

1.5. New RESTful apis


1.5.1. Initialize new zone

Will be sent by the config utility (probably radosgw-admin) to the master zonegroup.


POST /admin/zonegroup?init-zone

Input:

a JSON representation of the following:

 - zonegroup name
 - zone name
 - zone id
 - list of peers (zone ids)

Output:

a JSON representation of the following:
 - metadata of user to be used by zone
 - new zonegroup map

1.5.2. Notify of zonegroup map change

POST /admin/zonegroup?reconfigure

Input:

 - new zonegroup map

1.6. New radosgw-admin, radosgw interfaces:

1.6.1 Init new zonegroup

$ radosgw-admin zonegroup init --zonegroup=<name> [--master | --master-url=<url>]

When doing a remote command that contacts the master zonegroup, we'll also need to provide a uid, and access key. This can be done by specifying --uid and --access-key on the command line (which is a bit of a security problem), or by setting it in ceph.conf (which is a bit of a pain).

1.6.2 Init a new zone

$ radosgw-admin zone init --rgw-zone=<zone_name> --zonegroup=<zonegroup_name> --url=<zone url> [--master | --master-url=<url>]

This command will either set the initial master zone for the system, or wil create a new zone.

Optionally we can create a new zone implicity by running radosgw against a non existing zone, and specifying either --master or --master-url=...


1.6.3 Modifying zone configuration:

- Connect zone to another peer

$ radosgw-admin zone modify [--rgw-zone=<zone name>] --connect=<peer name>

- Disconnect zone from another peer

$ radosgw-admin zone modify [--rgw-zone=<zone name>] --disconnect-<peer name>

- Configure a zone placement target (storage policy)

$ radosgw-admin placement modify --placement-target=<name> ... (TBD what exactly)

- Check zone sync status:

$ radosgw-admin sync status [--rgw-zone=<zone name>]

Will provide current markers and timestamps for specified zone.


1.7. A usage example. Setting up two onegroups, with two zones in each:

Zonegroup: us-west

 Zone: us-west-1 (ceph cluster 1)
  - url: http://us-west-1.example.com

 Zone: us-west-2 (ceph cluster 2)
  - url: http://us-west-2.example.com

Zonegroup: us-east

 Zone: us-east-1 (ceph cluster 2)
 - url: http://us-east-1.example.com

 Zone: us-east-2 (ceph cluster 3)
  - url: http://us-east-2.example.com

 - In ceph cluster 1:

$ radosgw-admin zonegroup init --zonegroup=us-west --master --url=http://us-west-1.example.com
$ radosgw-admin zone init --rgw-zone=us-west-1 --zonegroup=us-west --url=http://us-west-1.example.com
$ radosgw --rgw-zone=us-west-1

 - In ceph cluster 2:
$ radosgw-admin zone init --rgw-zone=us-west-2 --zonegroup=us-west --url=http://us-west-2.example.com --master-url=http://us-west-1.example.com
$ radosgw --rgw-zone=us-west-2
$ radosgw-admin zonegroup init --zonegroup=us-east --url=http://us-east-1.example.com --master-url=http://us-west-1.example.com
$ radosgw-admin zone init --rgw-zone=us-east-1 --zonegroup=us-east --url=http://us-east-1.example.com --master-url=http://us-west-1.example.com
$ radosgw --rgw-zone=us-east-1

 - in ceph cluster 3:
$ radosgw-admin zone init --rgw-zone=us-east-1 --zonegroup=us-east --url=http://us-east-2.example.com --master-url=http://us-west-1.example.com
$ radosgw --rgw-zone=us-east-2



Note that these commands don't include the access keys to access the master zone. This will also need to be set, either through the command line, or via ceph.conf.

1.8. Optional simplification:
Instead of creating a zone and running radosgw, we can do it in one step via radosgw itself, e.g.:

 $ radosgw --rgw-zone=us-west-1 --zonegroup=us-west --init-zone --url=http://us-west-1.example.com

We can do the same for the zonegroup creation, so that every zone + zonegroup creation can be squashed to a single radosgw command.


2. New multizone implementation details

Here's the new sync scheme that we discussed. Note that it's very similar to the old scheme, but it adds a push notification. It does not specify how concurrency between multiple workers will be achieved, but there are a few ways to implement that: the same as with the old sync agent (lock shards), have a single elected worker per zone (use watch/notify for election), use watch-notify to sync work, specify workers manually, and potentially other solutions.

Note that this is going to be implemented as part of the gateway, which gives us more flexibility in how to leverage rados to store the sync state. Cross zone communication will still be done using RESTful api.


The idea is to work roughly at the same premise that we've been working before. We'll have 3 logs: metadata log, data log, bucket index log. We'll add push notifications to make changes appear quicker on the destination. The design supports active-active zones, and federated architecture.

2.1. Multi-zonegroup, multi-zone architecture

There still is only a single zone that is responsible for metadata updates. This zone is called the 'master' zone, and every other zone needs to make metadata changes against it.

Each zonegroup can have multiple zones. Each zone can have multiple peer zones, but not necessarily all the zones within that zonegroup. But it is required that there is a path between all the zones in the zonegroup (a connected graph).

zonegroup:
  name
  is_master?
    master zone
  list of zones

zone:
  containing zonegroup
  list of peers
  zone endpoints


Each bucket instance within each zone has a unique incrementing version id that is used to keep track of changes on that specific bucket.

A zone keeps a sync state of where it is synced with regard to all its peers. A zone keeps a metadata sync state against the master zone.

zone_data_sync_status:
  state: init, full_sync, incremental
  list of bucket instance states

bucket_instance_state:
  full_sync (keep start_marker+position) | incremental (keep position)
  list of object retries

The idea is that if we're doing a full sync of the bucket, we need to keep the source zone bucket index position, so that later on we'll catch all changes that went in since we started full syncing this bucket. We also keep the position of where we are at the full sync (what object we last synced). Also, before starting the full sync, we need to keep the state in the data (changed buckets) log.

When we're at the incremental stage, we need to keep the bucket index position. We follow the data log and sync each bucket instance that changed there.
Also, for every failed object sync we need to keep a retry entry.

zone data sync stages:
init:
Fetch the list of all the bucket instances and keep them in in a sharded sorted list

sync:
 for each bucket
   if bucket does not exist, fetch bucket, bucket.instance metadata from master zone
   sync bucket


Also, we need to keep a list of all the buckets that have objects that need to be resent

 
Metadata sync:

Similar to the data sync:

metadata_sync_status:
  state: init, full_sync, incremental

At the init state: keep the position of the metadata log. List all the metadata entries that exist and keep them in a sharded sorted list.
Full sync: for each entry in list, sync (fetch and store).
Incremental: follow changes in metadata log, store changes


Status inspection:

Provide the status of each zone, as a difference with regard to its peers (e.g., mtime of oldest non-synced change)

Push notifications:

A zone will send changes as they happen to all its connected peers. It will either send it as a change by change, or accumulate a few changes for a period of time and then send. These are just hints for the peers so that they could get the changes quicker, but if these are missed they will be picked up by the zones later through their regular sync process. The notifications will be done using a POST request between the source zone and the destination zone.



2.2. Active-active considerations

Each change has a 'source zone' assigned to it.
A change will not be applied if the dest zone's version mtime is greater or equal
 - we should keep a higher precision mtime as an object attribute, the stat() mtime only uses seconds, problematic

