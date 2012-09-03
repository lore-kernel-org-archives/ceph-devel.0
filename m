From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: RADOS gateway and the S3 compatibility.
Date: Mon, 03 Sep 2012 09:10:20 -0600
Message-ID: <504473FC02000099000E9622@collaborate.seakr.com>
References: <loom.20120903T104858-555@post.gmane.org>
 <CAC-hyiESAAtXu2woKQRN6K0U=8PV8LRkMYAozMcD_yq9W9PqUA@mail.gmail.com>
 <loom.20120903T145424-592@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:57596 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932200Ab2ICPKY convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:2:1>);
	Mon, 3 Sep 2012 11:10:24 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q83F7qu0007470
	for <ceph-devel@vger.kernel.org>; Mon, 3 Sep 2012 09:07:53 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 9C78444D00
	for <ceph-devel@vger.kernel.org>; Mon,  3 Sep 2012 09:10:21 -0600 (MDT)
In-Reply-To: <loom.20120903T145424-592@post.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>, ceph-devel@vger.kernel.org

>>> On 2012/09/03 at 06:56, ramu eppa <ramu.freesystems@gmail.com> wrote: 
> Hi,
> 
>   I disabled the default configuration and enable rgw.conf.But am getting 
> same 
> error.
> 
> Syntax error on line 1 of /etc/apache2/sites-enabled/rgw.conf:
> FastCgiExternalServer: redefinition of previously defined class 
> "/var/www/s3gw.fcgi"
> Action 'configtest' failed.
> The Apache error log may have more information.
>    ...fail!
> 
> please help me to configure radosgw and s3.
> 
> Thanks,
> Ramu.
> 

Look through *all* of your apache configuration files and verify that there is not another FastCgiExternalServer declaration somewhere.  If there is, comment it out and try, again.

-Nick



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
