From: Sage Weil <sage@newdream.net>
Subject: Re: ceph.spec.in problem in unstable ceph
Date: Wed, 4 Aug 2010 09:59:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1008040959130.16157@cobra.newdream.net>
References: <AANLkTikzSGtffR3oZAwVNsa5RNtkFXx9HvazFBhf501L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38047 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756839Ab0HDQ4y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Aug 2010 12:56:54 -0400
In-Reply-To: <AANLkTikzSGtffR3oZAwVNsa5RNtkFXx9HvazFBhf501L@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoguang Liu <syslxg@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

I pushed a fix to the testing branch, but I don't have a Fedora VM handy 
to test it.  Can you let me know if it resolves the problem?

Thanks-
sage


On Wed, 4 Aug 2010, Xiaoguang Liu wrote:

> rpmbuild fails at this line:
> 
> chmod 0644 $RPM_BUILD_ROOT%{_sysconfdir}/ceph/sample.ceph.conf
> 
> I think this is becuase sample.ceph.conf is no longer in /etc/ceph,
> but %{_docdir}/,  in unstable .
> 
> If I remove this line from spec file, rpmbuild fails at:
> 
> 
> RPM build errors:
>     File not found:
> /root/src/rpm/BUILDROOT/ceph-0.22rc-4.fc13.x86_64/usr/share/doc/sample.ceph.conf
>     File not found:
> /root/src/rpm/BUILDROOT/ceph-0.22rc-4.fc13.x86_64/usr/share/doc/sample.fetch_config
> 
> You may want to fix these two issues.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
