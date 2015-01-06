From: Loic Dachary <loic@dachary.org>
Subject: Ceph backports status report
Date: Tue, 06 Jan 2015 16:40:16 +0100
Message-ID: <54AC01E0.2030608@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ae21gFn4idMxSuTxfB3gOVpj9SkLqesQ5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34333 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755479AbbAFPkT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jan 2015 10:40:19 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 8D51442B2C
	for <ceph-devel@vger.kernel.org>; Tue,  6 Jan 2015 16:40:16 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ae21gFn4idMxSuTxfB3gOVpj9SkLqesQ5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Ceph co-developers,=20

Here is a list of the pending backports. If your name shows on an issue t=
hat needs to be backported to a stable release, it would be great if you =
could update the corresponding issue and/or create a pull request to cher=
ry-pick the relevant commits. If you would like help backporting, I'm ava=
ilable :-)

Cheers

http://tracker.ceph.com/issues/9985
	osd: incorrect atime calculation
	Author Sage Weil
	https://github.com/ceph/ceph/commit/4d0bba8b22ffaa13968950d0308e3c851bc3=
6769
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/9986
	objecter: map epoch skipping broken
	Author Sage Weil
	https://github.com/ceph/ceph/commit/e0166a23c2cf655bfb4cf873be021a14d9b9=
be27
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/9987
	mon: min_last_epoch_complete tracking broken
	Author Sage Weil
	https://github.com/ceph/ceph/commit/3fb731b722c50672a5a9de0c86a621f5f50f=
2d06
	giant	https://github.com/ceph/ceph/pull/3186
	firefly	https://github.com/ceph/ceph/pull/3220
	dumpling	to be backported
http://tracker.ceph.com/issues/9478
	Incorrect content type in response header
	Assigned to Yehuda Sadeh
	https://github.com/ceph/ceph/commit/31963459a0a869c4d32f55baa629f36df33e=
aa90
	firefly	to be backported
	giant	to be backported
http://tracker.ceph.com/issues/9479
	ETag is not included in the XML response to put object copy operation
	Assigned to Yehuda Sadeh
	https://github.com/ceph/ceph/commit/b1bfc3a7e0c9088f01f8ff770ae14f569fbc=
570d
	firefly	to be backported
	giant	to be backported
http://tracker.ceph.com/issues/10059
	osd/ECBackend.cc: 876: FAILED assert(0)
	Assigned to Samuel Just
	https://github.com/ceph/ceph/commit/c87bde64dfccb5d6ee2877cc74c66fc064b1=
bcd7
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/9998
	Replaced OSD weight below 0
	Assigned to Sage Weil
	https://github.com/ceph/ceph/commit/9902383c690dca9ed5ba667800413daa8332=
157e
	firefly	https://github.com/ceph/ceph/pull/3179
	giant	https://github.com/ceph/ceph/pull/3178
http://tracker.ceph.com/issues/10129
	Bad locking in the trunc method of libradosstriper=20
	Assigned to Sebastien Ponce
	https://github.com/ceph/ceph/commit/8613984373de946e1815cc84d50bbd4437a3=
f7a7
	giant	https://github.com/ceph/ceph/pull/2954
http://tracker.ceph.com/issues/10259
	mon health stuck with phantom hung requests
	Assigned to Samuel Just
	https://github.com/ceph/ceph/commit/1ac17c0a662e6079c2c57edde2b4dc947f54=
7f57
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/9878
	rhel7 s3-tests fail due to missing reason
	Author Sage Weil
	https://github.com/ceph/ceph/commit/a9dd4af401328e8f9071dee52470a0685ceb=
296b
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/10277
	ceph-fuse: Consistent pjd failure in getcwd
	Assigned to Zheng Yan
	https://github.com/ceph/ceph/commit/0827bb79ea5127e6763f6e904dfa1a326604=
6ffb
	giant	https://github.com/ceph/ceph/pull/3191
http://tracker.ceph.com/issues/10150
	osd/ReplicatedPG.cc: 10853: FAILED assert(r >=3D 0) (in _scan_range)
	Assigned to Samuel Just
	https://github.com/ceph/ceph/commit/dce6f288ad541fe7f0ef8374301cd712dd3b=
fa39
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/10157
	PGLog::(read|write)_log don't write out rollback_info_trimmed_to
	Assigned to Samuel Just
	https://github.com/ceph/ceph/commit/1fe8b846641486cc294fe7e1d2450132c38d=
2dba
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/9907
	radosgw-admin: can't disable max_size quota
	Author Yehuda Sadeh
	https://github.com/ceph/ceph/commit/abd3fd3ef9ee9999b99811937af60b7a5e67=
3e35
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/10014
	osd: spurious memmove on data payload
	Author Sage Weil
	https://github.com/ceph/ceph/commit/a1aa70f2f21339feabfe9c1b3c9c9f97fbd5=
3c9d
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/9910
	ceph_test_rados: out of order, probably due to message delay logic
	Assigned to Sage Weil
	https://github.com/ceph/ceph/commit/f7431cc3c25878057482007beb874c9d4473=
883e
	giant	to be backported
http://tracker.ceph.com/issues/9913
	mon: audit log entires for forwarded requests lack info
	Assigned to Joao Luis
	https://github.com/ceph/ceph/commit/87734747dca113d6a13d1e78da52e6009a9e=
935a
	giant	to be backported
http://tracker.ceph.com/issues/10299
	"ObjectCacher.cc: 530: FAILED assert(i->empty())" in rbd-firefly-distro-=
basic-multi run=20
	Assigned to Jason Dillaman
	https://github.com/ceph/ceph/commit/37a99694b1b4637b3b41b312809660d5139e=
8a23
	giant	to be backported
	firefly	to be backported
	dumpling	to be backported
http://tracker.ceph.com/issues/9918
	RGW-Swift: SubUser access permissions, does not seems to work
	Assigned to Yehuda Sadeh
	https://github.com/ceph/ceph/commit/5d9f36f757a7272c24d2c9adc31db1ed5e71=
2992
	firefly	to be backported
	giant	to be backported
http://tracker.ceph.com/issues/9536
	erasure-code: ISA plugin alignment must be constant
	Assigned to Loic Dachary
	https://github.com/ceph/ceph/commit/28c2b6e4f2bc6d77b9150fcf9a917d85c69c=
9ed1
	firefly	to be backported
http://tracker.ceph.com/issues/9921
	msgr/osd/pg dead lock giant
	Author Samuel Just
	https://github.com/ceph/ceph/commit/2d6980570af2226fdee0edfcfe5a8e7f60fa=
e615
	giant	to be backported
http://tracker.ceph.com/issues/8011
	osd/ReplicatedPG.cc: 5244: FAILED assert(soid < scrubber.start || soid >=
=3D scrubber.end)
	Assigned to Samuel Just
	https://github.com/ceph/ceph/commit/e66f2e36c06ca00c1147f922d3513f56b122=
a5c0
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/9675
	splitting a pool doesn't start when rule_id !=3D ruleset_id
	Assigned to Joao Luis
	https://github.com/ceph/ceph/commit/78e84f34da83abf5a62ae97bb84ab70774b1=
64a6
	dumpling	to be backported
	firefly	to be backported
	giant	to be backported
http://tracker.ceph.com/issues/9806
	Objecter: resend linger ops on split
	Assigned to Josh Durgin
	https://github.com/ceph/ceph/commit/cb9262abd7fd5f0a9f583bd34e4c425a049e=
56ce
	giant	to be backported
	firefly	to be backported
	dumpling	to be backported
http://tracker.ceph.com/issues/9555
	msg/Pipe.cc: 1513: FAILED assert(0 =3D=3D "old msgs despite reconnect_se=
q feature") (firefly)
	Assigned to Sage Weil
	https://github.com/ceph/ceph/commit/847e5e102522d651aa9687a54aaafcebf3af=
c596
	firefly	to be backported
http://tracker.ceph.com/issues/8654
	Parsing /etc/lsb-release for OSD metadata is not portable
	Assigned to Danny Al-Gaaf
	https://github.com/ceph/ceph/commit/0b3a3987d382ff33fdf892f189b30df22be8=
0e59
	firefly	https://github.com/ceph/ceph/pull/3128
http://tracker.ceph.com/issues/10329
	rgw: s3 need to return SignatureDoesNotMatch instead of AccessDenied
	Assigned to Yehuda Sadeh
	https://github.com/ceph/ceph/commit/ef75d720f289ce2e18c0047380a16b768886=
4560
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/8911
	RGW doesn't return 'x-timestamp' in header which is used by 'View Detail=
s' of OpenStack
	Assigned to Luis Pabon
	https://github.com/ceph/ceph/commit/5b41d80b7fb9ed96c26801fc42c044191bb1=
8d84
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/8797
	"ceph status" do not exit with python_2.7.8
	Assigned to Dan Mick
	https://github.com/ceph/ceph/commit/5ba9b8f21f8010c59dd84a0ef2acfec99e4b=
048f
	firefly	https://github.com/ceph/ceph/pull/3169
	giant	https://github.com/ceph/ceph/pull/3168
http://tracker.ceph.com/issues/10334
	rgw: s3 need to return InvalidAccessKeyId instead of AccessDenied
	Assigned to Yehuda Sadeh
	https://github.com/ceph/ceph/commit/56af795b1046a4c1bfba59e1fefde272bb0e=
5c1e
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/9915
	osd: eviction logic reversed
	Author Sage Weil
	https://github.com/ceph/ceph/commit/622c5ac41707069ef8db92cb67c9185acf12=
5d40
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/6756
	journal full hang on startup
	Assigned to Sage Weil
	https://github.com/ceph/ceph/commit/d8d27f13e11dcaefd3aa1c049b97c980283d=
a575
	emperor	to be backported
	dumpling	to be backported
http://tracker.ceph.com/issues/9254
	rgw: civetweb requires explicit \r\n for http headers
	Assigned to Yehuda Sadeh
	https://github.com/ceph/ceph/commit/7409ab3df18fb312dd6c9f79084f889c523a=
fdce
	firefly	to be backported
http://tracker.ceph.com/issues/9408
	erasure-code: misalignment
	Assigned to Loic Dachary
	https://github.com/ceph/ceph/commit/fdeeeb1b6be7a95f473ad33d3344a499a611=
06a1
	firefly	to be backported
http://tracker.ceph.com/issues/9617
	objecter shutdown races with msg dispatch
	Assigned to Josh Durgin
	https://github.com/ceph/ceph/commit/e506f896a9217324ab7a7865989f4454562a=
ed5f
	giant	to be backported
http://tracker.ceph.com/issues/9193
	notify does not return an error code on timeout
	Author Sage Weil
	https://github.com/ceph/ceph/commit/7c7bf5fee7be397ef141b947f532a2a0b356=
7b42
	firefly	to be backported
http://tracker.ceph.com/issues/10220
	"mon/Paxos.cc: 1033: FAILED assert(mon->is_leader())" in upgrade:dumplin=
g-firefly-x:stress-split-giant-distro-basic-vps run=20
	Assigned to Joao Luis
	https://github.com/ceph/ceph/commit/18534615f184ba56b441fd1d4242eb06debd=
fe13
	giant	to be backported
http://tracker.ceph.com/issues/10351
	mount.ceph prints spurious "mount: error writing /etc/mtab: Invalid argu=
ment"
	Author John Spray
	https://github.com/ceph/ceph/commit/bdd0e3c4bda97fe18487a58dd173a7dff752=
e1a2
	giant	https://github.com/ceph/ceph/pull/3289
	firefly	https://github.com/ceph/ceph/pull/3288
	emperor	https://github.com/ceph/ceph/pull/3287
http://tracker.ceph.com/issues/9235
	unittest_histogram test case Histogram.Position fail
	Assigned to Loic Dachary
	https://github.com/ceph/ceph/commit/ee02293ad2ef050672fa8c164ba17b10e8d4=
ceeb
	firefly	https://github.com/ceph/ceph/pull/3128
http://tracker.ceph.com/issues/9973
	Validation of Swift DLO manifest object ETag doesn't match OpenStack Swi=
ft behavior
	Assigned to Yehuda Sadeh
	https://github.com/ceph/ceph/commit/ef6d3ad964d34bc526dc4435486bd5c8cdc3=
b230
	firefly	to be backported
	giant	to be backported
http://tracker.ceph.com/issues/10103
	swift tests failing
	Author Sage Weil
	https://github.com/ceph/ceph/commit/9ba17a321db06d3d76c9295e411c76842194=
b25c
	giant	to be backported
	firefly	to be backported
http://tracker.ceph.com/issues/9854
	librbd: reads contending for cache space can cause livelock
	Assigned to Jason Dillaman
	https://github.com/ceph/ceph/commit/cd784eab22a329cd3eb3798feb9d975a4506=
c57e
	giant	to be backported
	firefly	to be backported
	dumpling	to be backported


P.S. Here is the script I used to create the report.

import re
from git import *
import subprocess
import json
import sys

merge_requests=3Djson.loads(subprocess.check_output("curl --silent --head=
er 'PRIVATE-TOKEN: -ByPXcjrSWB7_LuAbXzq' http://workbench.dachary.org/api=
/v3/projects/ceph%2Fceph-backports/merge_requests?state=3Dopened", shell=3D=
True))
pull2merge =3D {}
release2pulls =3D {}
pull2release =3D {}
for merge_request in merge_requests:
   source =3D merge_request['source_branch']
   (a, pull_request, b) =3D source.split('/')
   pull2merge[pull_request] =3D merge_request
   target =3D merge_request['target_branch']
   release2pulls.setdefault(target, []).append(pull_request)
   pull2release[pull_request] =3D target

repo =3D Repo(".")
releases =3D [ 'dumpling', 'emperor', 'firefly', 'giant']
commit2issue_id =3D {}
issue_id2backports =3D {}
issues=3D{}
issue_id2pulls=3D{}
for release in releases:
   for issue in json.loads(subprocess.check_output("curl --silent 'http:/=
/tracker.ceph.com/issues.json?project_id=3Dceph&status_id=3Dopen&limit=3D=
100&cf_2=3D%7E{release}' | jq '.issues'".format(release=3Drelease), shell=
=3DTrue)):
      detailed_issue =3D json.loads(subprocess.check_output("curl --silen=
t 'http://tracker.ceph.com/issues/{issue_id}.json?include=3Djournals' | j=
q .issue".format(issue_id=3Dissue['id']), shell=3DTrue))
      issues[issue['id']] =3D detailed_issue
      for field in detailed_issue['custom_fields']:
         if field['name'] =3D=3D 'Backport':
            detailed_issue['backports'] =3D re.findall('\w+', field['valu=
e'])
            break
   for pull in release2pulls.get(release, []):
      for c in repo.iter_commits('{release}..pull/{pull}/head'.format(rel=
ease=3Drelease, pull=3Dpull), no_merges=3DTrue):
         match =3D re.search(r'fixes\s*:\s*#*\s*(\d+)', c.message, re.IGN=
ORECASE)
         if match:
            issue_id =3D int(match.group(1))
            commit2issue_id[c.hexsha] =3D issue_id
            issue_id2backports.setdefault(issue_id, set()).add(release)
            issue_id2pulls.setdefault(issue_id, {})[release] =3D pull

issue_id2commit =3D {}
for c in repo.iter_commits('master', no_merges=3DTrue):
   match =3D re.search(r'fixes\s*:\s*#*\s*(\d+)', c.message, re.IGNORECAS=
E)
   if match:
      issue_id =3D int(match.group(1))
      issue_id2commit[issue_id] =3D c.hexsha

for (issue_id, backports) in issue_id2backports.iteritems():
   issue =3D issues.get(issue_id)
   if issue:
      missing =3D []
      for backport in backports:
         if backport not in issue['backports']:
            missing.append(backport)
   else:
      missing =3D backports
   if missing:
      if issue:
         print "http://tracker.ceph.com/issues/{issue_id} backports is {b=
ackports} and missing {missing}".format(issue_id=3Dissue_id, backports=3D=
existing_backports, missing=3D",".join(missing))
      else:
         print "http://tracker.ceph.com/issues/{issue_id} backports shoul=
d be {missing}".format(issue_id=3Dissue_id, missing=3D",".join(missing))
      for (release, pull) in issue_id2pulls[issue_id].iteritems():
         print "{release} https://github.com/ceph/ceph/pull/{pull}".forma=
t(release=3Drelease, pull=3Dpull)

for (issue_id, issue) in issues.iteritems():
   if issue_id not in issue_id2commit:
      match =3D re.search(r'commit:(\w+)', issue['description'])
      if match:
         issue_id2commit[issue_id] =3D repo.rev_parse(match.group(1))
   for journal in issue['journals']:
      if 'notes' not in journal:
         continue
      match =3D re.search(r'https://github.com/ceph/ceph/pull/(\d+)', jou=
rnal['notes'])
      if match:
         pull =3D match.group(1)
         if pull in pull2release:
            release =3D pull2release[pull]
            if ( release in issue_id2pulls.setdefault(issue_id, {}) and=20
                 issue_id2pulls[issue_id][release] !=3D pull):
               print "http://tracker.ceph.com/issues/{issue_id} {release}=
 backport is referenced by a commit from https://github.com/ceph/ceph/pul=
l/{existing} but the issue notes contain a URL to https://github.com/ceph=
/ceph/pull/{new} which is also against {release}".format(issue_id=3Dissue=
_id,release=3Drelease,existing=3Dissue_id2pulls[issue_id][release],new=3D=
pull)

for (issue_id, issue) in issues.iteritems():
   if (issue['status']['name'] !=3D 'Pending Backport' or
       issue['project']['name'] =3D=3D 'teuthology'):
      continue
   if issue_id not in issue_id2pulls:
      if issue_id not in issue_id2commit:
         print "http://tracker.ceph.com/issues/{issue_id} should be backp=
orted to {backports} but has no commit".format(issue_id=3Dissue_id, backp=
orts=3Dissue['backports'])
         continue
   pulls =3D issue_id2pulls.setdefault(issue_id, {})
   print "http://tracker.ceph.com/issues/{issue_id}".format(issue_id=3Dis=
sue_id)
   print "\t" + issue['subject']
   if 'assigned_to' in issue:
      print "\tAssigned to {assignee}".format(assignee=3Dissue['assigned_=
to']['name'])
   else:
      print "\tAuthor {author}".format(author=3Dissue['author']['name'])
   print "\thttps://github.com/ceph/ceph/commit/{commit}".format(commit=3D=
issue_id2commit.get(issue_id, ''))
   for release in issue['backports']:
      if issue_id in issue_id2pulls and release in issue_id2pulls[issue_i=
d]:
         print "\t{release}\thttps://github.com/ceph/ceph/pull/{pull}".fo=
rmat(release=3Drelease, pull=3Dissue_id2pulls[issue_id][release])
      else:
         print "\t{release}\tto be backported".format(release=3Drelease)


--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--ae21gFn4idMxSuTxfB3gOVpj9SkLqesQ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSsAeAACgkQ8dLMyEl6F22iCQCfe6yexfyQcvha67E5YW8msm7I
PSgAoMRplhGKw4vzCdkPdoN4EryH985y
=9eYv
-----END PGP SIGNATURE-----

--ae21gFn4idMxSuTxfB3gOVpj9SkLqesQ5--
