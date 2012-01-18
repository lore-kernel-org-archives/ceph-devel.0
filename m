From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Testing environment.
Date: Wed, 18 Jan 2012 08:43:30 -0800
Message-ID: <CAORUGqCZa4sULkVW-Kjd-8hm5c65=WWGw0J5d9O9ocaDcp6nZQ@mail.gmail.com>
References: <CAADCt4L-84gBJBdXgCjmW4N28v1eqFnGoz72d1Z0bLEnVRpNgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43904 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757975Ab2ARQnx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2012 11:43:53 -0500
Received: by werb13 with SMTP id b13so515773wer.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2012 08:43:52 -0800 (PST)
In-Reply-To: <CAADCt4L-84gBJBdXgCjmW4N28v1eqFnGoz72d1Z0bLEnVRpNgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Stepachev <octo47@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jan 17, 2012 at 22:59, Andrey Stepachev <octo47@gmail.com> wrot=
e:
> Hi,
>
> I want to test my changes in ceph. But for now I doesn't have automat=
ed
> solution. =D0=A1an someone of the developers will share with me his e=
nvironment
> or tell me how it can quickly set it up?

Brief description is of the current (old) setup is, we have a pile of
Ubuntu 10.10 boxes with the default user "ubuntu" created, run
https://github.com/NewDreamNetwork/ceph-qa-chef/blob/master/solo/solo-f=
rom-scratch
on them to prepare them, then use
https://github.com/NewDreamNetwork/teuthology with
https://github.com/NewDreamNetwork/ceph-qa-suite as config to run
regression tests on them.

Now, whether I expect you to be able to use that knowledge in any
meaningful fashion, that's a different question ;)

If you have code that follows SubmittingPatches passes unit tests
(make check), is neat (make distcheck) and passes your manual testing,
submit a Github pull request and I'm sure someone will run the
regression tests on it.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
