From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to test ? :p
Date: Fri, 26 Apr 2013 15:07:41 +0200
Message-ID: <CAF6-1L4J_VoEBPO1MmF5KMkqrperc3E-QNoXEnK4ied9G3goFg@mail.gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<51704AF4.7060908@42on.com>
	<CAF6-1L5uhOknmR7O6TtrYoiE6Sqb1FbN1-U2cpDbAR31-i2=5A@mail.gmail.com>
	<67AC8E8B-C295-49EA-BD52-39F06E3C5A37@openminds.be>
	<CAF6-1L50V3cn0Sqcw-LajZh=dO=x91HTe4mL2yQ-k5yiGeJ2sg@mail.gmail.com>
	<517664AD02000099000F6C41@collaborate.seakr.com>
	<CAF6-1L4HPK0A_T-PmsonFCFUmA5ugT8Y_CXmwdG7-erRnfEhSA@mail.gmail.com>
	<5176961F02000099000F6C70@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:48614 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246Ab3DZNHo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 09:07:44 -0400
Received: by mail-bk0-f50.google.com with SMTP id ik5so1740029bkc.9
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 06:07:42 -0700 (PDT)
In-Reply-To: <5176961F02000099000F6C70@collaborate.seakr.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>, Wido den Hollander <wido@42on.com>, pasik@iki.fi, Bernard Grymonpon <bernard@openminds.be>
Cc: ceph-devel@vger.kernel.org

Hi,


I just wanted to mention that I implemented a simple request merging
strategy to counter-act the request splitting done by the Xen block if
protocol.

The results are pretty good. When comparing to using the rbd kernel
module, I can now get 2-4x better write performance and 2x read
performance.


Cheers,

    Sylvain
