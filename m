From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Flapping osd / continuously reported as failed
Date: Fri, 24 Jan 2014 07:36:02 -0600
Message-ID: <52E26C42.6090806@inktank.com>
References: <0D057B737C42FC4AB3F22773A5C9425F259DBDEDD0@MXMBON06.grupa.onet> <CAPYLRzjGDep1ny6K-Ctz_7VG4THV6nAx9odOdjr=WNNesV4cVA@mail.gmail.com> <0D057B737C42FC4AB3F22773A5C9425F259DBDEDD1@MXMBON06.grupa.onet> <CAPYLRzhVtMCY+-d-y5F5M5hMVDwRh343+bB7An4Xcw4DT3n82w@mail.gmail.com> <0D057B737C42FC4AB3F22773A5C9425F259DBDF026@MXMBON06.grupa.onet> <ADBDB4FFB0814748AF32D0A1EE6E10AF228296D145@MXMBON06.grupa.onet> <CAPYLRzghUwEvu_f0aV2Q37JqnyCJ=46cTWiteTwN4=Tmqxd3HA@mail.gmail.com> <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C755@MXMBON06.grupa.onet> <CAPYLRzi8YLvg=sRq06QS3ju1gLxvCONucsOufhFjcbBPU2Av4A@mail.gmail.com> <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C9F0@MXMBON06.grupa.onet> <CAPYLRzjTmLG_DY4EbmDwndSg5x6ZBznbavxOoU_+Wxh1q8OcYg@mail.gmail.com> <loom.20140124T132806-603@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:63744 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaAXNgD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jan 2014 08:36:03 -0500
Received: by mail-ie0-f171.google.com with SMTP id as1so2797876iec.30
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jan 2014 05:36:02 -0800 (PST)
In-Reply-To: <loom.20140124T132806-603@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Maciej Bonin <maciej.bonin@m247.com>
Cc: ceph-devel@vger.kernel.org

On 01/24/2014 06:29 AM, Maciej Bonin wrote:
> Gregory Farnum <greg@...> writes:
>
>>
>> On Mon, Aug 19, 2013 at 3:09 PM, Mostowiec Dominik
>> <Dominik.Mostowiec@...> wrote:
>>> Hi,
>>>> Yes, it definitely can as scrubbing takes locks on the PG, which will
> prevent reads or writes while the
>> message is being processed (which will involve the rgw index being
> scanned).
>>> It is possible to tune scrubbing config for eliminate slow requests and
> marking osd down when large rgw
>> bucket index is scrubbing?
>>
>> Unfortunately not, or we would have mentioned it before. :/ There are
>> some proposals for sharding bucket indexes that would ameliorate this
>> problem, and on Cuttlefish or Dumpling the OSD won't get marked down,
>> but it will still block incoming requests on that object (ie, requests
>> to access the bucket) while the scrubbing is in place.
>> That said, that improvement might be sufficient since you haven't
>> actually shown us how long the object scrub takes.
>> -Greg
>> Software Engineer #42  <at>  http://inktank.com | http://ceph.com
>>
>
>
> Hello Guys,
>
> I just wanted to share that we've had a similar problem and we had solved it
> by borrowing sensible kernel option defaults from a radosgw patch iirc.
> net.ipv4.ip_local_port_range = 1024 65535
> net.core.netdev_max_backlog = 30000
> net.core.somaxconn = 4096
> net.ipv4.tcp_max_syn_backlog = 252144
> net.ipv4.tcp_max_tw_buckets = 360000
> net.ipv4.tcp_fin_timeout = 3
> net.ipv4.tcp_max_orphans = 262144
> net.ipv4.tcp_synack_retries = 2
> net.ipv4.tcp_syn_retries = 2

FWIW, these may not strictly help with the situation you described, but 
at least on our test cluster helped improve RGW performance in general 
on 10GbE+:

echo 33554432 | sudo tee /proc/sys/net/core/rmem_default
echo 33554432 | sudo tee /proc/sys/net/core/wmem_default
echo 33554432 | sudo tee /proc/sys/net/core/rmem_max
echo 33554432 | sudo tee /proc/sys/net/core/wmem_max
echo "10240 87380 33554432" | sudo tee /proc/sys/net/ipv4/tcp_rmem
echo "10240 87380 33554432" | sudo tee /proc/sys/net/ipv4/tcp_wmem
echo 250000 | sudo tee /proc/sys/net/core/netdev_max_backlog
echo 524288 | sudo tee /proc/sys/net/nf_conntrack_max
echo 1 | sudo tee /proc/sys/net/ipv4/tcp_tw_recycle
echo 1 | sudo tee /proc/sys/net/ipv4/tcp_tw_reuse

>
>
> Regards,
> Maciej Bonin
> Systems Engineer
> m247.com
> ISO 27001 Data Protection Classification: A - Public
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

