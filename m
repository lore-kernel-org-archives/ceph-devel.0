From: Gregory Farnum <greg@inktank.com>
Subject: Re: [RFC][PATCH] osd: Add local_connection to fast_dispatch in func _send_boot.
Date: Mon, 21 Jul 2014 13:54:47 -0700
Message-ID: <CAPYLRzjMKZ5RsaYLXGX054qq7BOmNL8rHVbKqzs+2-bZ=MajMw@mail.gmail.com>
References: <6AA21C22F0A5DA478922644AD2EC308C887C60@SHSMSX101.ccr.corp.intel.com>
	<CAPYLRzhx0JUPYV8Qbv0cCUxH1Wr_1Zm7s=N3YpF-_6Qit_SWWA@mail.gmail.com>
	<6AA21C22F0A5DA478922644AD2EC308C893D3E@SHSMSX101.ccr.corp.intel.com>
	<CAPYLRzjHLntr__i46Q61iQKa3YpcjcE67hhgy+wxZpESOMRYfg@mail.gmail.com>
	<6AA21C22F0A5DA478922644AD2EC308C895230@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:32996 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521AbaGUUys convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jul 2014 16:54:48 -0400
Received: by mail-wi0-f175.google.com with SMTP id ho1so4867423wib.8
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jul 2014 13:54:47 -0700 (PDT)
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C895230@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Jul 20, 2014 at 11:33 PM, Ma, Jianpeng <jianpeng.ma@intel.com> =
wrote:
>> Hrm, I'd really like to see the startup sequence. I see the crash oc=
curring, but I
>> don't understand how it's happening =E2=80=94 we test this pretty ex=
tensively so there
>> must be something about your testing configuration that is different=
 than ours.
>> Can you provide that part of the log, and maybe a little more descri=
ption of
>> what you think the problem is?
>
> If the ceph.conf contain "cluster addr",  the bug must occur.
> For no "cluster addr" in ceph.conf, the local-connection add to fast-=
dispatch in func  _send_boot/ cluster_messenger->set_addr_unknowns.
>
>>
>> In particular, we *always* call init_local_connection when the messe=
nger
>> starts, so every messenger who is allowed to receive EC messages sho=
uld have
>> the local connection set up before they get one.
> Yes you call init_local_connection. But only adding osd to messenger,=
 the local_conenction can add to dispatch.
> In func OSD::init
>         >>cluster_messenger->add_dispatcher_head(this);
> Only after this, the local_connection can add to dispatch.
> Because if local_connection has correct type, it can add to dispatch =
and don=E2=80=99t' care the cluster addr.
> When allocate a Messenger, it set the type and only after add_dispatc=
her_head/tail, the local-connection can add to dispatch.
> Maybe add ms_deliver_handle_fast_connect(local_connection.get())  in =
SimpleMessenger::ready is better.

Ooooookay, I see the problem now. I pulled the patch (with some
wording changes) into master at commit
9061988ec7eaa922e2b303d9eece86e7c8ee0fa1. I've also created a ticket
to clean up the local dispatch Connection setup at
http://tracker.ceph.com/issues/8892.
Thanks!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
