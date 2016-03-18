From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: what's the default package for configure without any parameters?
Date: Fri, 18 Mar 2016 12:43:31 +0100
Message-ID: <56EBE9E3.3000808@digiware.nl>
References: <CAKZcxgdGCFKA6r5pMxfnhT_5U7UbP=f0+PTqGbHqE_Wgcvw3qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:58771 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbcCRLnx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Mar 2016 07:43:53 -0400
In-Reply-To: <CAKZcxgdGCFKA6r5pMxfnhT_5U7UbP=f0+PTqGbHqE_Wgcvw3qQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>, ceph-devel@vger.kernel.org

On 18-3-2016 04:29, Jaze Lee wrote:
> Hi, all
>     I run the ./configure without any parameter.How can i know the
> default configure options?

You can run ./configure --help

Some options tell you what their default state is.
The others I

Otherwise browse thru configure.ac looking for the line with "WITH_"on it.
And the harder version just run it and examine the output.

I think that the S[] array in config.status could help.
Options there are TRUE/FALSE and the combo like:

S["FREEBSD_FALSE"]=""
S["FREEBSD_TRUE"]="#"

Would indicate that this is not FreeBSD.
And the WITH_ values are there also.

--WjW




