From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: It's not a bug of ceph, but
Date: Thu, 14 Apr 2011 03:09:53 +0300
Message-ID: <4DA63B51.6030601@ufm.su>
References: <4DA58180.7090701@ufm.su>	<BANLkTim_rn4uzJSBp+oNVst7nYyVrU3Q=g@mail.gmail.com> <Pine.LNX.4.64.1104130922120.13408@cobra.newdream.net> <4DA5FA4C.7030205@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:45164 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991Ab1DNAJ4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 13 Apr 2011 20:09:56 -0400
In-Reply-To: <4DA5FA4C.7030205@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Henry Chang <henry.cy.chang@gmail.com>, ceph-devel@vger.kernel.org

On 04/13/2011 10:32 PM, Fyodor Ustinov wrote:
>
> May be md. I test now without md.
It's not md.

Excellent. It seems that ubuntu 11.04 (or, may be, kernel 2.6.38?) do 
not have a working fs for ceph?

WBR,
     Fyodor.
