From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Compilation issues on Fedora 13 and Fedora 15
Date: Sun, 25 Mar 2012 12:14:15 +0200
Message-ID: <4F6EEFF7.4020901@widodh.nl>
References: <1332665829.7312.8.camel@indica.cc.iitb.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:51732 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362Ab2CYKOQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Mar 2012 06:14:16 -0400
In-Reply-To: <1332665829.7312.8.camel@indica.cc.iitb.ac.in>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ajit@iitb.ac.in
Cc: ceph-devel@vger.kernel.org

Hi,

On 03/25/2012 10:57 AM, Ajit K Jena wrote:
> Hello All,
>
> I have lost touch with the growth of ceph after version 0.30.
> I am trying to compile version 0.43 and 0.44 on FC13 and FC15.
> It does not build successfully. I get the following error:
>
>     make[3]: *** No rule to make target `leveldb/libleveldb.a', needed by
> `ceph-osd'.  Stop.
>     make[3]: *** Waiting for unfinished jobs....
>
> I have the following questions:
>
>    a) What is this error about ? Has CEPH dropped Fedora as a target
>       OS platform ?
>
>    b) What is the best suited OS for building/testing CEPH prototypes ?
>
> Thanks for your attention.

Did you init the GIT submodules?

$ git submodule init
$ git submodule update

Wido

>
> --ajit
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
