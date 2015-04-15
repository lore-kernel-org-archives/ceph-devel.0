From: Andrey Korolyov <andrey@xdel.ru>
Subject: leaking mons on a latest dumpling
Date: Wed, 15 Apr 2015 19:38:43 +0300
Message-ID: <CABYiri9j=bDPGu1KLTzvywt6shCnJ7AWbtywV8WoUtG8m1=_xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35274 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965133AbbDOQjG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Apr 2015 12:39:06 -0400
Received: by lbbuc2 with SMTP id uc2so38509599lbb.2
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2015 09:39:04 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

there is a slow leak which is presented in all ceph versions I assume
but it is positively exposed only on large time spans and on large
clusters. It looks like the lower is monitor placed in the quorum
hierarchy, the higher the leak is:


{"election_epoch":26,"quorum":[0,1,2,3,4],"quorum_names":["0","1","2","3","4"],"quorum_leader_name":"0","monmap":{"epoch":1,"fsid":"a2ec787e-3551-4a6f-aa24-deedbd8f8d01","modified":"2015-03-05
13:48:54.696784","created":"2015-03-05
13:48:54.696784","mons":[{"rank":0,"name":"0","addr":"10.0.1.91:6789\/0"},{"rank":1,"name":"1","addr":"10.0.1.92:6789\/0"},{"rank":2,"name":"2","addr":"10.0.1.93:6789\/0"},{"rank":3,"name":"3","addr":"10.0.1.94:6789\/0"},{"rank":4,"name":"4","addr":"10.0.1.95:6789\/0"}]}}

ceph heap stats -m 10.0.1.95:6789 | grep Actual
MALLOC: =    427626648 (  407.8 MiB) Actual memory used (physical + swap)
ceph heap stats -m 10.0.1.94:6789 | grep Actual
MALLOC: =    289550488 (  276.1 MiB) Actual memory used (physical + swap)
ceph heap stats -m 10.0.1.93:6789 | grep Actual
MALLOC: =    230592664 (  219.9 MiB) Actual memory used (physical + swap)
ceph heap stats -m 10.0.1.92:6789 | grep Actual
MALLOC: =    253710488 (  242.0 MiB) Actual memory used (physical + swap)
ceph heap stats -m 10.0.1.91:6789 | grep Actual
MALLOC: =     97112216 (   92.6 MiB) Actual memory used (physical + swap)

for almost same uptime, the data difference is:
rd KB 55365750505
wr KB 82719722467

The leak itself is not very critical but of course requires some
script work to restart monitors at least once per month on a 300Tb
cluster to prevent >1G memory consumption by monitor processes. Given
a current status for a dumpling, it would be probably possible to
identify leak source and then forward-port fix to the newer releases,
as the freshest version I am running on a large scale is a top of
dumpling branch, otherwise it would require enormous amount of time to
check fix proposals.

Thanks!
