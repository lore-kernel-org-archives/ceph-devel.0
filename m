From: Wido den Hollander <wido@widodh.nl>
Subject: Re: [PATCH] docs: Add CloudStack documentation
Date: Thu, 06 Sep 2012 00:39:23 +0200
Message-ID: <5047D49B.3060105@widodh.nl>
References: <1344462671-21848-1-git-send-email-wido@widodh.nl> <CADxhoDR-3guBfFXc_QSmvPthVp5R=vS9tB2zpn-WRaLCSAu=ZA@mail.gmail.com> <50476FAE.8030107@widodh.nl> <CADvuQRGsRQ2AYM7ceaQiR-F+7J1P1TR-_AXfPLWHznYetkhoog@mail.gmail.com> <5047866B.80102@widodh.nl> <CADvuQREoGMAL+fKTMpYDk73-8f5yWVNHTAjpiHrLFEO6noFJ4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:58278 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759739Ab2IEWjZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 18:39:25 -0400
In-Reply-To: <CADvuQREoGMAL+fKTMpYDk73-8f5yWVNHTAjpiHrLFEO6noFJ4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 09/05/2012 08:22 PM, Tommi Virtanen wrote:
> On Wed, Sep 5, 2012 at 10:05 AM, Wido den Hollander <wido@widodh.nl> wrote:
>>> For example, rbd:?id=admin&secret=s3kr1t&mon=1.2.3.4&mon=5.6.7.8&pool=rbd
>>> is perfectly legal.
>>>
>>> Whether some Java library fails to implement generic URIs is another
>>> concern..
>> It is indeed a Java library in this case:
>> http://docs.oracle.com/javase/6/docs/api/java/net/URI.html
>
> I don't see anything on that page to prevent you from doing
> u.getQuery() and using the fields from that (and then living with Java
> lack of good stdlib and using something like
> http://stackoverflow.com/questions/1667278/parsing-query-strings-in-java
> to actually parse the string into key=value pairs).
>

The main problem with that is how CloudStack internally stores the data. 
At the storage driver the URI doesn't arrive in plain format, it gets 
splitted with getHost(), getAuthUsername(), getPath() and arrives in 
these separate variables at the point where libvirt is being called.

Wido

> Or, use *exactly* what the QEmu RBD code is doing, by getting the data
> our of the URI with getSchemeSpecificPart -- that'll work as long as
> you don't start the part with a slash ("rbd:/").
>
> I see no reason here why the
> rbd:poolname/devicename[@snapshotname][:option1=value1[:option2=value2...]]
> syntax from QEmu wouldn't work, just as is.
>
