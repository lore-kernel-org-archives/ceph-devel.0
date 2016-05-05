From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: on-the-wire encryption, addrs, and cephx
Date: Thu, 5 May 2016 15:44:34 -0400 (EDT)
Message-ID: <757099045.26361700.1462477474700.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1605050822230.15413@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:44553 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbcEETof (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2016 15:44:35 -0400
In-Reply-To: <alpine.DEB.2.11.1605050822230.15413@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

Hi,

----- Original Message -----
> From: "Sage Weil" <sweil@redhat.com>
> To: ceph-devel@vger.kernel.org
> Sent: Thursday, May 5, 2016 8:57:16 AM
> Subject: on-the-wire encryption, addrs, and cephx
> 
> Hi all,
> 
> We had a call last night (Marcus, Haomai, Yehuda, our GSoC student Zhao,
> and me) to discuss on-the-wire encryption.  

<snip>

> 
> (We talked about whether just jumping into a Kerberos world wholesale
> makes sense or would help here, and decided that although we could do what
> cephx does with kerberos, doing so doesn't change any of the protocol
> pieces--and in fact krb5 would effectivel slot in as an alternative,
> pluggable auth mode next to cephx.  As we go through this process we
> should verify that a native kerberos approach fits in properly.)

<snip>

> 
> Comments, questions welcome!


Seems like this is a great start.  I'm used to systems that emphasize Kerberos, and I'm glad we're revisiting where it covers or misses our requirements.

Matt

> 
> sage
> --

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
