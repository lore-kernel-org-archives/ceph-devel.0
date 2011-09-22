From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: radosgw should support cdmi?
Date: Thu, 22 Sep 2011 09:09:52 -0700
Message-ID: <CAORUGqDuEXvLxpibgO2FAJG3c5xrP3smayLkZP5fJrQarfRxig@mail.gmail.com>
References: <Pine.LNX.4.64.1109192033450.23670@cobra.newdream.net> <CAMwB3Ti3J8cdstYzpe_m7+wRfnctoTN=w+FY1w_jW4hiFH5KOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43127 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab1IVQKQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2011 12:10:16 -0400
Received: by eya28 with SMTP id 28so1686921eya.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2011 09:10:15 -0700 (PDT)
In-Reply-To: <CAMwB3Ti3J8cdstYzpe_m7+wRfnctoTN=w+FY1w_jW4hiFH5KOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?S=C5=82awomir_Skowron?= <szibis@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

2011/9/22 S=C5=82awomir Skowron <szibis@gmail.com>:
> On Tue, Sep 20, 2011 at 5:39 AM, Sage Weil <sage@newdream.net> wrote:
>> http://www.snia.org/cdmi
> Any decision ?? I would like to see this in RadosGW, especially, rang=
e
> support in Object Restfull API.

The S3-like API already supports range requests, using the standard
HTTP Range: header.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
