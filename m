From: Chu Duc Minh <chu.ducminh@gmail.com>
Subject: Re: Create/Quota/Mount pool
Date: Sat, 17 Mar 2012 12:55:58 +0700
Message-ID: <4F64276E.5090407@gmail.com>
References: <4F6327FB.4070104@gmail.com> <Pine.LNX.4.64.1203160830320.31380@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50164 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab2CQF4H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Mar 2012 01:56:07 -0400
Received: by dajr28 with SMTP id r28so7148348daj.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Mar 2012 22:56:06 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1203160830320.31380@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 03/16/2012 10:32 PM, Sage Weil wrote:
> On Fri, 16 Mar 2012, Chu Duc Minh wrote:
>> Hi, i'm searching a way to create more data(s) pool and quota for each pool.
>> Do you know how to select pool to mount when using ceph client. (i'm using
>> kernel 3.0.x)
> You can create pools with
>
>   ceph osd pool create<poolname>
>
> make them usable by the fs with
>
>   ceph mds add_data_pool<poolname>
>
> and then set a subdirectory to use that pool for new files with cephfs
> (man cephfs).
>
> If you run into problems, let us know; this isn't well documented yet!
>
> sage
Hi, how can I know the ID of new <poolname>, because it's needed for 
cephfs command? Or i must use numeric <poolname>?
I'm using Cephx for auth, how can i set permission for a individual 
client only can mount & see a specify subdirectory/pool?
I succeeded when using numeric poolname but fail on "ceph auth add ..." 
and mount.
(I tried many options for ceph auth add ... - but still does not success)

Thank you very much!
