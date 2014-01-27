From: Kyle Bader <kyle.bader@gmail.com>
Subject: Re: RADOS + deep scrubbing performance issues in production environment
Date: Mon, 27 Jan 2014 13:10:23 -0500
Message-ID: <CAFMfnwp4u-O8m3gZko35y5t3r05kAgt9zUWOew_pmHSJjmLPmA@mail.gmail.com>
References: <20140127151321.GD26390@philipgian-mac>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39244 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbaA0SKY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 13:10:24 -0500
Received: by mail-qc0-f174.google.com with SMTP id x13so8561359qcv.33
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jan 2014 10:10:23 -0800 (PST)
In-Reply-To: <20140127151321.GD26390@philipgian-mac>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Filippos Giannakos <philipgian@grnet.gr>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, synnefo-devel@googlegroups.com

> Are there any tools we are not aware of for controlling, possibly pausing,
> deep-scrub and/or getting some progress about the procedure ?
> Also since I believe it would be a bad practice to disable deep-scrubbing do you
> have any recommendations of how to work around (or even solve) this issue ?

The periodicity of scrubs is controllable with these tunables:

osd scrub max interval
osd deep scrub interval

You may also be interested in adjusting:

osd scrub load threshold

More information on the docs page:

http://ceph.com/docs/master/rados/configuration/osd-config-ref/#scrubbing

Hope that helps some!

-- 

Kyle
