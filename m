From: Loic Dachary <loic@dachary.org>
Subject: Understanding a jewel rgw test failure
Date: Mon, 15 Aug 2016 11:18:34 +0200
Message-ID: <57B188EA.5060203@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44028 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbcHOJSj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Aug 2016 05:18:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Orit,

I'm trying to figure out why 

http://pulpito.ceph.com/loic-2016-08-12_08:10:12-rgw-jewel-backports---basic-smithi/359320

fails because 

2016-08-12T08:48:23.495 INFO:tasks.util.rgw: json result: {u'data': {u'attrs': [{u'val': u'AgJtAAAAAwIOAAAAAwAAAGZvbwMAAABGb28DA1MAAAABAQAAAAMAAABmb28PAAAAAQAAAAMAAABmb28EAy4AAAACAgQAAAAAAAAAAwAAAGZvbwAAAAAAAAAAAgIEAAAADwAAAAMAAABGb28AAAAAAAAAAA==', u'key': u'user.rgw.acl'}, {u'val': u'', u'key': u'user.rgw.idtag'}, {u'val': u'', u'key': u'user.rgw.manifest'}], u'bucket_info': {u'has_instance_obj': u'true', u'has_website': u'false', u'swift_versioning': u'false', u'bucket': {u'name': u'mybar', u'bucket_id': u'r0z0.4146.1', u'marker': u'r0z0.4146.1', u'data_extra_pool': u'.region0.r0z0.data_extra_pool', u'pool': u'.region0.r0z0.data_pool', u'index_pool': u'.region0.r0z0.index_pool'}, u'bi_shard_hash_type': 0, u'creation_time': u'0.000000', u'quota': {u'max_objects': -1, u'enabled': False, u
 'max_size_kb': -1}, u'flags': 0, u'swift_ver_location': u'', u'owner': u'foo', u'requester_pays': u'false', u'zonegroup': u'region0', u'placement_rule': u'default_placement', u'num_shards': 0}}, u'v
 e
r': {u'tag': u'_ULKFEsWDkO1MTMfq5zsPZI2', u'ver': 1}, u'key': u'bucket.instance:mybar:r0z0.4146.1', u'mtime': u'2016-08-12 08:47:20.050731Z'}

2016-08-12T08:48:23.885 INFO:tasks.util.rgw: json result: {u'data': {u'attrs': [{u'val': u'AgJtAAAAAwIOAAAAAwAAAGZvbwMAAABGb28DA1MAAAABAQAAAAMAAABmb28PAAAAAQAAAAMAAABmb28EAy4AAAACAgQAAAAAAAAAAwAAAGZvbwAAAAAAAAAAAgIEAAAADwAAAAMAAABGb28AAAAAAAAAAA==', u'key': u'user.rgw.acl'}, {u'val': u'', u'key': u'user.rgw.idtag'}, {u'val': u'', u'key': u'user.rgw.manifest'}], u'bucket_info': {u'has_instance_obj': u'true', u'has_website': u'false', u'swift_versioning': u'false', u'bucket': {u'name': u'mybar', u'bucket_id': u'r0z0.4146.1', u'marker': u'r0z0.4146.1', u'data_extra_pool': u'.region0.r0z1.data_extra_pool', u'pool': u'.region0.r0z1.data_pool', u'index_pool': u'.region0.r0z1.index_pool'}, u'bi_shard_hash_type': 0, u'creation_time': u'0.000000', u'quota': {u'max_objects': -1, u'enabled': False, u
 'max_size_kb': -1}, u'flags': 0, u'swift_ver_location': u'', u'owner': u'foo', u'requester_pays': u'false', u'zonegroup': u'region0', u'placement_rule': u'default_placement', u'num_shards': 0}}, u'v
 e
r': {u'tag': u'_ULKFEsWDkO1MTMfq5zsPZI2', u'ver': 1}, u'key': u'bucket.instance:mybar:r0z0.4146.1', u'mtime': u'2016-08-12 08:47:20.050731Z'}

have a data_extra_pool that differ ( .region0.r0z0.data_extra_pool and .region0.r0z1.data_extra_pool ). The same job (modulo xfs.yaml facets) recently passed on master at

http://pulpito.ceph.com/owasserm-2016-08-13_13:33:38-rgw-wip-hammer-orit---basic-smithi/361698

I don't see any difference between the ceph-qa-suite jewel and master branch, i.e. whatever problem there is, it is not because something is missing there.

git log --no-merges --oneline --cherry-mark --left-right ceph/jewel...ceph/master -- suites/rgw

I guess one of the rgw backports at https://github.com/ceph/ceph/tree/jewel-backports creates the problem. Could it be because of

https://github.com/ceph/ceph/pull/10537/files

?

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
