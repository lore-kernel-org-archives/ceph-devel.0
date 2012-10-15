From: Gregory Farnum <greg@inktank.com>
Subject: Re: Help...MDS Continuously Segfaulting
Date: Mon, 15 Oct 2012 10:26:32 -0700
Message-ID: <CAPYLRzhJb8Z=yXofTVC+vBk3JHYx+CXM2iA12cQG3GzWSmdwdg@mail.gmail.com>
References: <507BED3702000099000ECA13@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56135 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391Ab2JOR0c convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Oct 2012 13:26:32 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so8213181iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 10:26:32 -0700 (PDT)
In-Reply-To: <507BED3702000099000ECA13@collaborate.seakr.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>
Cc: ceph-devel@vger.kernel.org

Something in the MDS log is bad or is poking at a bug in the code. Can
you turn on MDS debugging and restart a daemon and put that log
somewhere accessible?
debug mds = 20
debug journaler = 20
debug ms = 1
-Greg

On Mon, Oct 15, 2012 at 10:02 AM, Nick Couchman <Nick.Couchman@seakr.com> wrote:
> Well, both of my MDSs seem to be down right now, and then continually segfault (every time I try to start them) with the following:
>
> ceph-mdsmon-a:~ # ceph-mds -n mds.b -c /etc/ceph/ceph.conf -f
> starting mds.b at :/0
> *** Caught signal (Segmentation fault) **
>  in thread 7fbe0d61d700
>  ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
>  1: ceph-mds() [0x7ef83a]
>  2: (()+0xfd00) [0x7fbe15a0cd00]
>  3: (ESession::replay(MDS*)+0x3ea) [0x4dcfea]
>  4: (MDLog::_replay_thread()+0x6b6) [0x6a2446]
>  5: (MDLog::ReplayThread::entry()+0xd) [0x4cf5ed]
>  6: (()+0x7f05) [0x7fbe15a04f05]
>  7: (clone()+0x6d) [0x7fbe14bc410d]
> 2012-10-15 10:57:35.449161 7fbe0d61d700 -1 *** Caught signal (Segmentation fault) **
>  in thread 7fbe0d61d700
>
>  ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
>  1: ceph-mds() [0x7ef83a]
>  2: (()+0xfd00) [0x7fbe15a0cd00]
>  3: (ESession::replay(MDS*)+0x3ea) [0x4dcfea]
>  4: (MDLog::_replay_thread()+0x6b6) [0x6a2446]
>  5: (MDLog::ReplayThread::entry()+0xd) [0x4cf5ed]
>  6: (()+0x7f05) [0x7fbe15a04f05]
>  7: (clone()+0x6d) [0x7fbe14bc410d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
>      0> 2012-10-15 10:57:35.449161 7fbe0d61d700 -1 *** Caught signal (Segmentation fault) **
>  in thread 7fbe0d61d700
>
>  ceph version 0.48.1argonaut (commit:a7ad701b9bd479f20429f19e6fea7373ca6bba7c)
>  1: ceph-mds() [0x7ef83a]
>  2: (()+0xfd00) [0x7fbe15a0cd00]
>  3: (ESession::replay(MDS*)+0x3ea) [0x4dcfea]
>  4: (MDLog::_replay_thread()+0x6b6) [0x6a2446]
>  5: (MDLog::ReplayThread::entry()+0xd) [0x4cf5ed]
>  6: (()+0x7f05) [0x7fbe15a04f05]
>  7: (clone()+0x6d) [0x7fbe14bc410d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
> Segmentation fault
>
> Anyone have any hints on recovering?  I'm running 0.48.1argonaut - I can attempt to upgrade to 0.48.2 and see if that helps, but I figured if anyone can offer any insight as to what to do to get the replay to run without segfaulting?
>
>
>
> --------
> This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
