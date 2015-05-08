From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: long running workloads/rbd_fsx_cache_writeback.yaml on hammer
Date: Fri, 8 May 2015 11:03:12 -0400 (EDT)
Message-ID: <209815215.14051495.1431097392961.JavaMail.zimbra@redhat.com>
References: <554C7CE5.4070600@dachary.org> <1191272410.13855776.1431088583253.JavaMail.zimbra@redhat.com> <554CC970.3040701@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:52950 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbbEHPEQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 11:04:16 -0400
In-Reply-To: <554CC970.3040701@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

Since it sounds like the next hammer release is more or less ready, my =
vote would be that the fix can wait until the next release.  Since it w=
ill only occur if the new exclusive lock feature is enabled (disabled o=
n images by default) and the connection between librbd and the OSD is r=
eset with writeback data waiting in the cache, it sounds like a rare en=
ough issue.

=46inal decision rests w/ Josh.

--=20

Jason Dillaman=20
Red Hat=20
dillaman@redhat.com=20
http://www.redhat.com=20


----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Jason Dillaman" <dillaman@redhat.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Friday, May 8, 2015 10:34:24 AM
Subject: Re: long running workloads/rbd_fsx_cache_writeback.yaml on ham=
mer

Hi,

On 08/05/2015 14:36, Jason Dillaman wrote:
> Nice catch.  It is deadlocked in a code path between handling a watch=
/notify error from librados and flushing the internal cache.  The issue=
 already appears to exist in the hammer branch.

I'm glad it helped you figure out a bug :-) From the point of view of t=
he upcoming v0.94.2, do you think we should wait until this is fixed ? =
Or is it rare enough and can wait until v0.94.3 ? I'm asking because th=
is bug seems to be the only potential blocker for v0.94.2. It's ok eith=
er way, just let me know .

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
