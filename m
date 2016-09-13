From: Haomai Wang <haomai@xsky.com>
Subject: Re: Mismatching nonce for 'ceph osd.0 tell'
Date: Tue, 13 Sep 2016 10:29:16 +0800
Message-ID: <CACJqLybyu1_rKj7g7qSfrtZCVMhJvgcvU2Q7vfoRUvs-3hT3JQ@mail.gmail.com>
References: <f54dda71-dabf-cab2-948c-83b9f2007aff@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-hk2apc01on0133.outbound.protection.outlook.com ([104.47.124.133]:40000
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752199AbcIMC3d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Sep 2016 22:29:33 -0400
Received: by mail-vk0-f49.google.com with SMTP id v189so160642940vkv.1
        for <ceph-devel@vger.kernel.org>; Mon, 12 Sep 2016 19:29:22 -0700 (PDT)
In-Reply-To: <f54dda71-dabf-cab2-948c-83b9f2007aff@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Sep 13, 2016 at 6:59 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi
>
> When running  cephtool-test-mon.sh, part of it executes:
>   ceph tell osd.0 version
> I see reports on the commandline, I guess that this is the OSD
> complaining that things are wrong:
>
> 2016-09-12 23:50:39.239037 814e50e00  0 -- 127.0.0.1:0/1925715881 >>
> 127.0.0.1:6800/26384 conn(0x814fde800 sd=18 :-1
> s=STATE_CONNECTING_WAIT_BANNER_AND_IDENTIFY pgs=0 cs=0
> l=1)._process_connection connect claims to be 127.0.0.1:6800/1026384 not
> 127.0.0.1:6800/26384 - wrong node!
>
> Which it will run until it is shot down.... after 3600 secs.
>
> the nonce is incremented with 1000000 on every rebind.
>
> But what I do not understand is how this mismatch has occurred.
> I would expect port 6800 to be the port on which the OSD is connected
> too, so the connecting party (ceph in this case) thinks the nonce to be
> 1026384. Did the MON have this information? And where did the MON then
> get it from....
>
> Somewhere one of the parts did not receive the new nonce, or did not
> also increment it?

nonce is a part of ceph_entity_addr, so OSDMap will take this

>
> Any suggestions welcomed on directions where to look,
>
> Thanx,
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
