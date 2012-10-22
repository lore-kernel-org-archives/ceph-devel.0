From: Joe Buck <jbbuck@gmail.com>
Subject: Re: Proposed change to vstart.sh
Date: Mon, 22 Oct 2012 09:35:12 -0700
Message-ID: <508575C0.9080700@gmail.com>
References: <508469CE.3000502@gmail.com> <alpine.DEB.2.00.1210211434320.26885@cobra.newdream.net> <508562A1.2040106@gmail.com> <50856F74.8020001@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61334 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab2JVQfO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 12:35:14 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2123113pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 09:35:14 -0700 (PDT)
In-Reply-To: <50856F74.8020001@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sam,

Here's the last few lines printed when I start vstart.sh

./vstart.sh: 397: ./vstart.sh: btrfs: not found
add osd0 7cf25a23-32dd-4b82-b9d4-d514eb857d02
2012-10-22 09:31:46.788605 7ff87bb4e780 -1 unable to authenticate as 
client.admin
2012-10-22 09:31:46.790370 7ff87bb4e780 -1 ceph_tool_common_init failed.

I'm invoking vstart.sh like so (my version has the patch I sent out this 
morning applied):
./vstart.sh -d -n -l -X

The line in vstart.sh that seems to tank is:

$SUDO $CEPH_ADM osd create $uuid

-Joe Buck

On 10/22/2012 09:08 AM, Sam Lang wrote:
> On 10/22/2012 10:13 AM, Joe Buck wrote:
>> On 10/21/2012 02:35 PM, Sage Weil wrote:
>
>>> Also, we should fix the auth none usage at some point.  :)
>
> I made some changes a while back to fix the auth none problems with 
> vstart 
> (https://github.com/ceph/ceph/commit/0f7c516f3e1f37c5869f8fbff67f53ca0c90568c). 
>  The -x help text inversion was a bug on my part.
>
> Joe what errors do you get with auth none?  I'm able to do vstart.sh 
> -n -l (without the -x/-X changes) successfully.
>
> -sam
>
>>>
>>> sage
>>
>

