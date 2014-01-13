From: Kyle Bader <kyle@inktank.com>
Subject: Re: Reliability models
Date: Mon, 13 Jan 2014 09:25:14 -0800
Message-ID: <CAHxYaFP2Au1A61B=v3BZLhjdYEXDuO5C_0CLZy3O52TNy=asDg@mail.gmail.com>
References: <52D3A85E.4050301@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:47919 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbaAMRZP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jan 2014 12:25:15 -0500
Received: by mail-oa0-f52.google.com with SMTP id o6so8170163oag.25
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jan 2014 09:25:15 -0800 (PST)
In-Reply-To: <52D3A85E.4050301@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

> IIRC you figured out how to use https://github.com/ceph/ceph-tools/tree/master/models . Do you happen to have some kind of HOWTO or even the list of commands you've used to get me started ?

git clone ...ceph-tools
cd ceph-tools/models/reliability
./main.py -g

At this point a graphical form should pop up and most of it should be
straight forward. NRE rate is non recoverable read errors, the NRE
model determines how an array/disk responds to a non recoverable read
error event. I tend to be on the conservative end having seen my share
of RAID horror shows so I set the NRE model to "fail". The other
gotcha is most disk manufacturers use MTBF or AFR while the
reliability modeling tool requests FITS. The formula you will need is:

MTBF = 1,000,000,000 x 1/FIT. [1]

Stripe length is the number of RADOS objects that are require to store
a blob of data, ie all RADOS objects that compose a RBD volume. Since
this code was written a while ago there is no code to support modeling
erasure coded objects. If you have any questions, let me know!

[1] http://en.wikipedia.org/wiki/Failure_rate#Units

-- 
Kyle Bader - Inktank
Senior Solution Architect
