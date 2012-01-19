From: Andrey Stepachev <octo47@gmail.com>
Subject: Re: Testing environment.
Date: Thu, 19 Jan 2012 12:47:53 +0400
Message-ID: <CAADCt4K7CJDYBZwZULyofA3bgQ_Ohz+WtDvNLuj2bcDT68FqkQ@mail.gmail.com>
References: <CAADCt4L-84gBJBdXgCjmW4N28v1eqFnGoz72d1Z0bLEnVRpNgg@mail.gmail.com>
 <CAORUGqCZa4sULkVW-Kjd-8hm5c65=WWGw0J5d9O9ocaDcp6nZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33052 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab2ASIsP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jan 2012 03:48:15 -0500
Received: by wics10 with SMTP id s10so173825wic.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jan 2012 00:48:14 -0800 (PST)
In-Reply-To: <CAORUGqCZa4sULkVW-Kjd-8hm5c65=WWGw0J5d9O9ocaDcp6nZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Thanks!
I'll try to do something with that. Thanks :)

2012/1/18 Tommi Virtanen <tommi.virtanen@dreamhost.com>:
> On Tue, Jan 17, 2012 at 22:59, Andrey Stepachev <octo47@gmail.com> wr=
ote:
>> Hi,
>>
>> I want to test my changes in ceph. But for now I doesn't have automa=
ted
>> solution. =D0=A1an someone of the developers will share with me his =
environment
>> or tell me how it can quickly set it up?
>
> Brief description is of the current (old) setup is, we have a pile of
> Ubuntu 10.10 boxes with the default user "ubuntu" created, run
> https://github.com/NewDreamNetwork/ceph-qa-chef/blob/master/solo/solo=
-from-scratch
> on them to prepare them, then use
> https://github.com/NewDreamNetwork/teuthology with
> https://github.com/NewDreamNetwork/ceph-qa-suite as config to run
> regression tests on them.
>
> Now, whether I expect you to be able to use that knowledge in any
> meaningful fashion, that's a different question ;)
>
> If you have code that follows SubmittingPatches passes unit tests
> (make check), is neat (make distcheck) and passes your manual testing=
,
> submit a Github pull request and I'm sure someone will run the
> regression tests on it.



--=20
Andrey.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
