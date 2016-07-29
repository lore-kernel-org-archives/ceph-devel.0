From: John Spray <jspray@redhat.com>
Subject: Re: Active/Active MDS
Date: Fri, 29 Jul 2016 10:45:44 +0100
Message-ID: <CALe9h7ciOVDU0V-FSJH7XQmFD5mGQ--A-w030jF5V_=8HK8iYw@mail.gmail.com>
References: <CALSMtUBtwuRyoX0XmLYRBvjdMuSEs7-bmO5OtXr4RRapVrg7dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:35123 "EHLO
	mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbcG2JqG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 05:46:06 -0400
Received: by mail-qt0-f170.google.com with SMTP id x25so63535997qtx.2
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 02:46:04 -0700 (PDT)
In-Reply-To: <CALSMtUBtwuRyoX0XmLYRBvjdMuSEs7-bmO5OtXr4RRapVrg7dw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bill Webb <billwebbatl@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jul 28, 2016 at 11:50 PM, Bill Webb <billwebbatl@gmail.com> wro=
te:
> Hello,
>
> We have a bit of interest in seeing MDS support Active-Active HA.  I=E2=
=80=99d
> be interested to learn about the status of this, and possibly
> contribute.  What is the best way to proceed?

Depending on available skills, your options for contribution are:
 * Ad-hoc testing (i.e. push workloads through a system and see what
happens, then produce high quality bug reports)
 * Development of automated tests (i.e. additions to ceph-qa-suite run
with teuthology, requires getting familiar with that environment)
 * Fixing bugs (requires substantial expertise on the code)

You can filter open issues by the multi-mds category (and end up with
a horrific URL apparently):
http://tracker.ceph.com/projects/cephfs/issues?utf8=3D%E2%9C%93&set_fil=
ter=3D1&f%5B%5D=3Dstatus_id&op%5Bstatus_id%5D=3Do&f%5B%5D=3Dcategory_id=
&op%5Bcategory_id%5D=3D%3D&v%5Bcategory_id%5D%5B%5D=3D90&f%5B%5D=3D&c%5=
B%5D=3Dproject&c%5B%5D=3Dtracker&c%5B%5D=3Dstatus&c%5B%5D=3Dpriority&c%=
5B%5D=3Dsubject&c%5B%5D=3Dassigned_to&c%5B%5D=3Dupdated_on&c%5B%5D=3Dca=
tegory&c%5B%5D=3Dfixed_version&c%5B%5D=3Dcf_3&group_by=3D

John
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
