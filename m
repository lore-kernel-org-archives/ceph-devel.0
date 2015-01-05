From: John Spray <john.spray@redhat.com>
Subject: Re: Ceph backports
Date: Mon, 5 Jan 2015 12:03:14 +0000
Message-ID: <CAGd4Wr2aw1ODd=06dQa7HQzbFu6sYZeQGTOV5Vn6VW+j6dK63g@mail.gmail.com>
References: <54AA7B46.6090706@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:41826 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbbAEMDQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 07:03:16 -0500
Received: by mail-la0-f52.google.com with SMTP id hs14so17825908lab.25
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jan 2015 04:03:14 -0800 (PST)
In-Reply-To: <54AA7B46.6090706@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sounds sane -- is the new plan to always do backports via this
process?  i.e. if I see a backport PR which has not been through
integration testing, should I refrain from merging it?

John

On Mon, Jan 5, 2015 at 11:53 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ceph,
>
> I'm going to spend time to care for the Ceph backports (i.e. help red=
uce the time they stay in pull requests or redmine tickets). It should =
roughly go as follows:
>
> 0. Developer follows normal process to land PR to master. Once comple=
te and ticket is marked Pending Backport this process initiates.
> 1. I periodically polls Redmine to look for tickets in Pending Backpo=
rt state
> 2. I find commit associated with Redmine ticket and Cherry Picks it t=
o backport integration branch off of desired maintenance branch (Dumpin=
g, Firefly, etc). (Note - patch may require backport to multiple branch=
es)
> 3. I resolve any merge conflicts with the cherry-picked commit
> 4. Once satisfied with group of backported commits to integration bra=
nch, I notifies QE.
> 5. QE tests backport integration branch against appropriate suites
> 6a. If QE is satisfied with test results, they merge backport integra=
tion branch.
> 6b. If QE is NOT satisfied with the test results, they indicate backp=
ort integration branch is NOT ready to merge and return to me to work w=
ith original Developer to resolve issue and return to steps 2/3
> 7. Ticket is moved to Resolved once backport integration branch conta=
ining cherry-picked backport is merged to the desired mainteance branch=
(es)
>
> I'll first try to implement this semi manually and document / script =
when convenient. If anyone has ideas to improve this tentative process,=
 now is the time :-)
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
