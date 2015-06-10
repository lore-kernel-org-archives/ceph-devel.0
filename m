From: Owen Synge <osynge@suse.com>
Subject: Re: what this would look like if the system is with templates.
Date: Wed, 10 Jun 2015 12:44:30 +0200
Message-ID: <5578150E.2070007@suse.com>
References: <5548807A.6060103@dachary.org> <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com> <5548D57E.3050406@dachary.org> <55491307.8010203@redhat.com> <554914EC.6000102@dachary.org> <alpine.DEB.2.00.1505051231040.13336@cobra.newdream.net> <55771E30.8070308@suse.com> <5577202D.2040007@suse.com> <55777164.6090201@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:59756 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbFJKpt (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Wed, 10 Jun 2015 06:45:49 -0400
In-Reply-To: <55777164.6090201@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, Sage Weil <sweil@redhat.com>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 06/10/2015 01:06 AM, Ken Dreyer wrote:
> On 06/09/2015 11:19 AM, Owen Synge wrote:
>>
>>> we can be remove many hard coded values replaced with variable and that
>>> probably will only grow in number for example
>>>
>>> 	%if 0%{?rhel} || 0%{?fedora}
>>> 		--with-systemd-libexec-dir=/usr/libexec/ceph \
>>> 	%endif
>>> 	%if 0%{?opensuse} || 0%{?suse_version}
>>> 		--with-systemd-libexec-dir=/usr/lib/ceph/ \
>>> 	%endif
>>
>> 	--with-systemd-libexec-dir=@systemd_libexec_dir@ \
>>
>> No OS distribution specific rubbish needed :)
> 
> Passing an autoconf variable (@systemd_libexec_dir@) to an autoconf
> argument (--with-systemd-libexec-dir) seems really over-complicated to me.

It makes separating things like version info from function hard.

The %else function is a minefield.

The %if statements around nearly every line in configure give you a hint
of the problem.

Autotools is not the last word in pretty language but it does warn when
you do platform specific stuff very well, and its a lot more flexible
than rpm.

> I don't see the issues with putting os-specific things in the .spec
> file; that's how many other (non-Ceph) projects do it.

These conditionals do not occur just done once if used in the spec.in
file though its worse, you need the same conditionals on each of

	configure
	files
	install

Admittedly if we follow the current process of deprecating direct
platform based installs we can get the conditionals down to two places
in the spec.in file rather than 3.

I think having the conditionals set in one place is superior to 2 or 3
places. To do this you would template the rpm spec file.

Best regards

Owen
