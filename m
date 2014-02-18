From: Dan van der Ster <daniel.vanderster@cern.ch>
Subject: Re: [Ceph-maintainers] disabling updatedb
Date: Tue, 18 Feb 2014 19:20:03 +0100
Message-ID: <CABZ+qqkfe_WA36vH0vf+6HNy1qR-hsy8PLTbEUJKvLC1GeTbWQ@mail.gmail.com>
References: <alpine.DEB.2.00.1402180845440.15052@cobra.newdream.net> <8738jg2trm.fsf@meteor.durcheinandertal.bofh>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:48510 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbaBRSZx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Feb 2014 13:25:53 -0500
Received: by mail-pa0-f50.google.com with SMTP id kp14so17161473pab.9
        for <ceph-devel@vger.kernel.org>; Tue, 18 Feb 2014 10:20:44 -0800
 (PST)
In-Reply-To: <8738jg2trm.fsf@meteor.durcheinandertal.bofh>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gaudenz Steinlin <gaudenz@debian.org>
Cc: Sage Weil <sage@inktank.com>, ceph-maintainers@ceph.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On Tue, Feb 18, 2014 at 6:52 PM, Gaudenz Steinlin <gaudenz@debian.org> wrote:
>
> Hi
>
> Sage Weil <sage@inktank.com> writes:
>
>> Dan at CERN noticed that his performance was tanking because updatedb was
>> running against /var/lib/ceph.  updatedb has a PRUNE line in
>> /etc/updatedb.conf that we should presumably be adding ourselves to.  One
>> user pointed out a package that uses sed to rewrite this line in the init
>> script on start.
>>
>> I have two questions:
>>
>> - is there no better way than sed to add ourselves to this list?
>> - should we do it in the init script, or postinst, or both?
>>
>> Presumably this is a problem others have solved with other packages.
>
> At least for Debian neither solution is appropriate. Changing other
> packages conffiles in postinst scripts is forbidden by policy. There is
> also no way to preserve this reliably over upgrades without user
> interaction. I'm not sure if there is an explicit policy for init
> scripts, but this seems equally wrong. Also it's unclear how one would
> handle the case were an administrator does NOT want to exclude this
> directory.
>
> The only solution I see if you really want to completely exclude the
> directory is to convince the mlocate maintainers to either add the
> directory to the default configuration or to add something like an
> /etc/updatedb.d directory where packages can drop configuration file
> snippets. But the latter seems like overkill to me.
>
> The real question to me is why an updatedb run can drastically impact
> ceph performance. At least in Debian updatedb is run with ionice
> -c3 in the "Idle" scheduling class. According to the man page this
> means: "A program running with idle I/O priority will only get disk time
> when no other program has asked for disk I/O for a defined grace period.
> The impact of an idle I/O process on normal system activity should be
> zero. This scheduling class does not take a priority argument.
> Presently, this scheduling class is permitted for an ordinary user
> (since kernel 2.6.25)." So it should not have any negative effect.
>
> Maybe CERN (or the distribution they use) should also run updatedb under
> ionice.

updatedb _is_ run under ionice on our systems (RHEL), but IO
scheduling classes are only implemented by the cfq scheduler.
We use deadline, which is recommended for an enterprise disk server,
and indeed measured more stable IO latencies with deadline than with
cfq. And when you run updatedb on a deadline scheduled drive, there
are so many reads queued up that writes can be starved for many 10s of
seconds.

In our case, we've already added /var/lib/ceph to the PRUNEPATHS via
their puppet configuration. Though an upstream solution is probably a
good idea since I would assume that most ceph deployments use deadline
and this would hit most of them eventually once they have enough
files. In addition, as someone else mentioned, you'd better add ceph
to the pruned fs types as well, just like /afs is pruned at the
moment, lest every client spend all day stat'ing their big cephfs
namespace.

Cheers, Dan

-- Dan van der Ster || Data & Storage Services || CERN IT Department --

>
> Gaudenz
>
> --
> Ever tried. Ever failed. No matter.
> Try again. Fail again. Fail better.
> ~ Samuel Beckett ~
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
