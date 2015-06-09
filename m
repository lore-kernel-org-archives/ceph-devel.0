From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: what this would look like if the system is with templates.
Date: Tue, 09 Jun 2015 17:06:12 -0600
Message-ID: <55777164.6090201@redhat.com>
References: <5548807A.6060103@dachary.org> <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com> <5548D57E.3050406@dachary.org> <55491307.8010203@redhat.com> <554914EC.6000102@dachary.org> <alpine.DEB.2.00.1505051231040.13336@cobra.newdream.net> <55771E30.8070308@suse.com> <5577202D.2040007@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37134 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009AbbFIXGO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Jun 2015 19:06:14 -0400
In-Reply-To: <5577202D.2040007@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>, Sage Weil <sweil@redhat.com>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 06/09/2015 11:19 AM, Owen Synge wrote:
> 
>> we can be remove many hard coded values replaced with variable and that
>> probably will only grow in number for example
>>
>> 	%if 0%{?rhel} || 0%{?fedora}
>> 		--with-systemd-libexec-dir=/usr/libexec/ceph \
>> 	%endif
>> 	%if 0%{?opensuse} || 0%{?suse_version}
>> 		--with-systemd-libexec-dir=/usr/lib/ceph/ \
>> 	%endif
> 
> 	--with-systemd-libexec-dir=@systemd_libexec_dir@ \
> 
> No OS distribution specific rubbish needed :)

Passing an autoconf variable (@systemd_libexec_dir@) to an autoconf
argument (--with-systemd-libexec-dir) seems really over-complicated to me.

I don't see the issues with putting os-specific things in the .spec
file; that's how many other (non-Ceph) projects do it.

- Ken
