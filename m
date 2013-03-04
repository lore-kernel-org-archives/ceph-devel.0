From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 1/3] libceph: drop mutex while allocating a message
Date: Mon, 04 Mar 2013 13:52:20 -0600
Message-ID: <5134FB74.9050607@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E3AD.4080906@inktank.com> <5134E3F1.70008@inktank.com> <CAPYLRzhQeqbEK6wp+V8OWaAeyML1Uqh60vc0omanTyvCsXtTXQ@mail.gmail.com> <5134F53A.1010601@inktank.com> <CAPYLRzjwNgLro0RZORGsxU4e0nmDZTNpUQ2rTrB7Mk0ER6m_hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:55127 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758289Ab3CDTwU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 14:52:20 -0500
Received: by mail-ie0-f175.google.com with SMTP id c12so6541642ieb.20
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 11:52:20 -0800 (PST)
In-Reply-To: <CAPYLRzjwNgLro0RZORGsxU4e0nmDZTNpUQ2rTrB7Mk0ER6m_hQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/04/2013 01:39 PM, Gregory Farnum wrote:
>> My purpose in doing this is to make the third patch in
>> > this series trivial to review.
> The one that doesn't set the page_alignment for mds messages? *confused*
> 


Sorry, second patch in the series.	-Alex
