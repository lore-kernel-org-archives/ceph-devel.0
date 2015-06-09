From: Owen Synge <osynge@suse.com>
Subject: what this would look like if the system is with templates.
Date: Tue, 09 Jun 2015 19:19:41 +0200
Message-ID: <5577202D.2040007@suse.com>
References: <5548807A.6060103@dachary.org> <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com> <5548D57E.3050406@dachary.org> <55491307.8010203@redhat.com> <554914EC.6000102@dachary.org> <alpine.DEB.2.00.1505051231040.13336@cobra.newdream.net> <55771E30.8070308@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:58750 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbbFIRVI (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 9 Jun 2015 13:21:08 -0400
In-Reply-To: <55771E30.8070308@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Loic Dachary <loic@dachary.org>
Cc: Ken Dreyer <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>


> we can be remove many hard coded values replaced with variable and that
> probably will only grow in number for example
> 
> 	%if 0%{?rhel} || 0%{?fedora}
> 		--with-systemd-libexec-dir=/usr/libexec/ceph \
> 	%endif
> 	%if 0%{?opensuse} || 0%{?suse_version}
> 		--with-systemd-libexec-dir=/usr/lib/ceph/ \
> 	%endif

	--with-systemd-libexec-dir=@systemd_libexec_dir@ \

No OS distribution specific rubbish needed :)

Best regards

Owen



