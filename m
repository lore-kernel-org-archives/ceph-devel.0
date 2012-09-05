From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] docs: Add CloudStack documentation
Date: Wed, 5 Sep 2012 11:22:36 -0700
Message-ID: <CADvuQREoGMAL+fKTMpYDk73-8f5yWVNHTAjpiHrLFEO6noFJ4w@mail.gmail.com>
References: <1344462671-21848-1-git-send-email-wido@widodh.nl>
 <CADxhoDR-3guBfFXc_QSmvPthVp5R=vS9tB2zpn-WRaLCSAu=ZA@mail.gmail.com>
 <50476FAE.8030107@widodh.nl> <CADvuQRGsRQ2AYM7ceaQiR-F+7J1P1TR-_AXfPLWHznYetkhoog@mail.gmail.com>
 <5047866B.80102@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34243 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab2IESW7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 14:22:59 -0400
Received: by vbbff1 with SMTP id ff1so445801vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 05 Sep 2012 11:22:58 -0700 (PDT)
In-Reply-To: <5047866B.80102@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Calvin Morrow <calvin.morrow@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Sep 5, 2012 at 10:05 AM, Wido den Hollander <wido@widodh.nl> wrote:
>> For example, rbd:?id=admin&secret=s3kr1t&mon=1.2.3.4&mon=5.6.7.8&pool=rbd
>> is perfectly legal.
>>
>> Whether some Java library fails to implement generic URIs is another
>> concern..
> It is indeed a Java library in this case:
> http://docs.oracle.com/javase/6/docs/api/java/net/URI.html

I don't see anything on that page to prevent you from doing
u.getQuery() and using the fields from that (and then living with Java
lack of good stdlib and using something like
http://stackoverflow.com/questions/1667278/parsing-query-strings-in-java
to actually parse the string into key=value pairs).

Or, use *exactly* what the QEmu RBD code is doing, by getting the data
our of the URI with getSchemeSpecificPart -- that'll work as long as
you don't start the part with a slash ("rbd:/").

I see no reason here why the
rbd:poolname/devicename[@snapshotname][:option1=value1[:option2=value2...]]
syntax from QEmu wouldn't work, just as is.
