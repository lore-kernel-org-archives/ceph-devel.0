From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: missing health status details
Date: Fri, 22 Nov 2013 13:48:39 +0000
Message-ID: <528F60B7.9080307@inktank.com>
References: <24E144B8C0207547AD09C467A8259F7559234656@lisa.maurer-it.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:60289 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627Ab3KVNsi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Nov 2013 08:48:38 -0500
Received: by mail-we0-f172.google.com with SMTP id t60so1155130wes.17
        for <ceph-devel@vger.kernel.org>; Fri, 22 Nov 2013 05:48:37 -0800 (PST)
In-Reply-To: <24E144B8C0207547AD09C467A8259F7559234656@lisa.maurer-it.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Good catch.  Opened ticket 6850 on the tracker.

http://tracker.ceph.com/issues/6850

   -Joao

On 11/22/2013 10:21 AM, Dietmar Maurer wrote:
> Just playing around, and detected this:
>
> # ceph health -f json-pretty
>
> { "summary": [],
>    "timechecks": { "epoch": 34,
>        "round": 40,
>        "round_status": "finished",
>        "mons": [
>              { "name": "1",
>                "skew": "0.000000",
>                "latency": "0.000000",
>                "health": "HEALTH_OK"},
>              { "name": "0",
>                "skew": "-0.000330",
>                "latency": "0.001454",
>                "health": "HEALTH_OK"},
>              { "name": "2",
>                "skew": "0.054170",
>                "latency": "0.000816",
>                "health": "HEALTH_WARN",
>                "details": "clock skew 0.0541703s > max 0.05s"}]},
>    "health": { "health_services": [
>              { "mons": [
>                      { "name": "1",
>                        "kb_total": 2064208,
>                        "kb_used": 1424964,
>                        "kb_avail": 534388,
>                        "avail_percent": 25,
>                        "last_updated": "2013-11-22 11:14:47.500872",
>                        "store_stats": { "bytes_total": 9524208,
>                            "bytes_sst": 8999282,
>                            "bytes_log": 458752,
>                            "bytes_misc": 66174,
>                            "last_updated": "0.000000"},
>                        "health": "HEALTH_WARN",
>                        "health_detail": "low disk space!"},
>                      { "name": "0",
>                        "kb_total": 2064208,
>                        "kb_used": 1249116,
>                        "kb_avail": 710236,
>                        "avail_percent": 34,
>                        "last_updated": "2013-11-22 11:14:53.498853",
>                        "store_stats": { "bytes_total": 10048528,
>                            "bytes_sst": 8999314,
>                            "bytes_log": 983040,
>                            "bytes_misc": 66174,
>                            "last_updated": "0.000000"},
>                        "health": "HEALTH_OK"},
>                      { "name": "2",
>                        "kb_total": 2064208,
>                        "kb_used": 1247084,
>                        "kb_avail": 712268,
>                        "avail_percent": 34,
>                        "last_updated": "2013-11-22 11:14:28.720368",
>                        "store_stats": { "bytes_total": 10048528,
>                            "bytes_sst": 8999314,
>                            "bytes_log": 983040,
>                            "bytes_misc": 66174,
>                            "last_updated": "0.000000"},
>                        "health": "HEALTH_OK"}]}]},
>    "overall_status": "HEALTH_WARN",
>    "detail": [
>          "mon.2 addr 192.168.3.13:6789\/0 clock skew 0.0541703s > max 0.05s (latency 0.000815989s)"]}
>
>
> Why is "low disk space!" not included inside 'details'?
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
