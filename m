From: John Spray <jspray@redhat.com>
Subject: Re: Integers as String in osd_metadata (memory, rotational)
Date: Tue, 28 Nov 2017 11:53:58 +0000
Message-ID: <CALe9h7foTN+tfM4n07AwS6iOLzRyFOFi-NTLMMV1=_FPHVHamA@mail.gmail.com>
References: <83609177.5513.1511867211100@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:45999 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754518AbdK1LyU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Nov 2017 06:54:20 -0500
Received: by mail-wm0-f52.google.com with SMTP id 9so1246786wme.4
        for <ceph-devel@vger.kernel.org>; Tue, 28 Nov 2017 03:54:19 -0800 (PST)
In-Reply-To: <83609177.5513.1511867211100@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 28, 2017 at 11:06 AM, Wido den Hollander <wido@42on.com> wrote:
> Hi,
>
> Looking at 'ceph osd metadata' I see that we return a lot of values as Strings in the JSON instead of a Integer, for example:
>
> $ ceph osd metadata 2033
>
> {
>     "id": 2033,
>     "arch": "x86_64",
>     "journal_rotational": "0",
>     "mem_swap_kb": "1046524",
>     "mem_total_kb": "63641808",
>     "rotational": "1"
> }
>
> Looking at some code I found this:
>
> (*m)["mem_total_kb"] = std::to_string(size);
> (*pm)["rotational"] = store_is_rotational ? "1" : "0";
> (*pm)["journal_rotational"] = journal_is_rotational ? "1" : "0";
>
> Why can't we return a int/long there? Is it the internal JSON parser which can't handle it?

There are various places where we send metadata as map<string, string>
(in this instance, MOSDBoot), which is indeed kind of annoying --
converting them all to a JSON-ish structure would be a good thing.

I'm imagining a helper class that wraps boost::property_tree and slots
in everywhere we currently use map<string, string> for metadata.

John

> Otherwise I'll write a PR for this. Saves me casting the things to Integers again afterwards in Python.
>
> Wido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
