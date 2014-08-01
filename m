From: Owen Synge <osynge@suse.com>
Subject: call for comments -> "ceph-disk" making OSD directories on typos
 and is inconsistent (useability).
Date: Fri, 01 Aug 2014 10:45:16 +0200
Message-ID: <53DB539C.8090306@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:55622 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaHAIpo (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 1 Aug 2014 04:45:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear all,

By default "ceph-disk" will do the following:

# ceph-disk -vvvv prepare  --fs-type xfs --cluster ceph -- /dev/sdk
DEBUG:ceph-disk:Preparing osd data dir /dev/sdk

No block device "/dev/sdk" exists so "ceph-disk" decides a block device
is not wanted and makes a directory for an OSD.

I think as policy "ceph-disk" should not assume by default, that a non
existent target is correct, make a directory for the "disk" type OSD to
reside in, and set it up as a "disk" type OSD.

Hence I proposed this patch:

https://github.com/ceph/ceph/pull/2160

As a second best option I would be happier with an explicit "don=92t fa=
il
if target is not present and just make a directory at the target". But
then you get on to the question of deeper directory structures being
handled:

The current behavior with deeper directory structures is currently
inconsistent as this output shows:

# ceph-disk prepare --fs-type xfs --cluster ceph -- /mnt/vdu/vdu
Traceback (most recent call last):
  File "/usr/sbin/ceph-disk", line 2605, in <module>
    main()
  File "/usr/sbin/ceph-disk", line 2583, in main
    args.func(args)
  File "/usr/sbin/ceph-disk", line 1311, in main_prepare
    os.mkdir(args.data)
OSError: [Errno 2] No such file or directory: '/mnt/vdu/vdu'

I think as a third best option would be to only make directories the
"--data-dir" parameter is used, but still suffers the deeper directory
structures question.

I am still unsure if I like the idea of creating directories for deeper
directory structures, as again the potential for typos leading to vastl=
y
different directory paths with a single misplaced character, and for
consistency would rather "ceph-disk" just failed if the target is not
available.

Although I propose failing fast and clearly with a clear error message
when a target does not exist, removing the assumption that all non
existent targets are valid and "disk" based OSD's and to try and make a=
n
"appropriate" directory, I do see 2 issues with this change:

(A) This is a change to the current default behavior so effecting
deployment frameworks.
(B) This would effect "ceph-deploy" which under some circumstances uses
this behavior.

I propose the following patch to mitigate side effect (B).

https://github.com/ceph/ceph-deploy/pull/224

I see no way to resolve issue (A) in general if my proposal for change
is selected.

I have discussed this issue with "alfredodeza" on IRC both privately an=
d
later on the "ceph-devel" IRC channel and he is "really divided here"
hence we decided I would bring this up for discussion on this mailing l=
ist.

Best regards

Owen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
