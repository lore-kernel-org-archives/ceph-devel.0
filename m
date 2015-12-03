From: Haomai Wang <haomai@xsky.com>
Subject: Re: queue_transaction interface + unique_ptr
Date: Thu, 3 Dec 2015 13:21:02 +0800
Message-ID: <CACJqLyZDoNWzDErNm5FVwP5wZMNcVJs0V0P7UDfBCgjQ=VBVxA@mail.gmail.com>
References: <CO1PR02MB208E42BE84D3D7BF2048668F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0131.outbound.protection.outlook.com ([104.47.126.131]:34528
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750749AbbLCFVR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 00:21:17 -0500
Received: by igl9 with SMTP id 9so4089404igl.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Dec 2015 21:21:02 -0800 (PST)
In-Reply-To: <CO1PR02MB208E42BE84D3D7BF2048668F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Sage Weil (sage@newdream.net)" <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Dec 3, 2015 at 8:17 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Hi Sage/Sam,
> As discussed in today's performance meeting , I am planning to change the queue_transactions() interface to the following.
>
>   int queue_transactions(Sequencer *osr, list<TransactionRef>& tls,
>                          Context *onreadable, Context *ondisk=0,
>                          Context *onreadable_sync=0,
>                          TrackedOpRef op = TrackedOpRef(),
>                          ThreadPool::TPHandle *handle = NULL) ;
>
> typedef unique_ptr<Transaction> TransactionRef;
>
>
> IMO , there is a problem with this approach.
>
> The interface like apply_transaction(), queue_transaction() etc. basically the interfaces taking single transaction pointer and internally forming a list to call the queue_transactions() also needs to be changed to accept TransactionRef which will be *bad*. The reason is while preparing list internally we need to move the uniqueue_ptr and callers won't be aware of that.
>
> Also, now changing every interfaces (and callers) that is taking Transaction* will produce a very big delta (and big testing effort as well).
>
> So, should we *reconsider* co-existing both  queue_transactions() interfaces and call the new one from the IO path ?

I like this, isolate any share_ptr area is a hard job. Look forward to!

>
> Thanks & Regards
> Somnath
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
