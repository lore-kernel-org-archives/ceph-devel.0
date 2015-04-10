From: Jian Wen <wenjianhn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Prioritize Heartbeat packets
Date: Fri, 10 Apr 2015 14:39:06 +0800
Message-ID: <CAMXzGWJJpDbV0M0rtTkoRU=tSkgi3tM=x6Sy+wKhfZ=oPNy2hw@mail.gmail.com>
References: <1985102496.575.1409186929716.JavaMail.root@thunderbeast.private.linuxbox.com>
	<alpine.DEB.2.00.1408271755160.966@cobra.newdream.net>
	<ltmnkp$tod$1@ger.gmane.org>
	<CAANLjFrHdDNJnMnWQk3s2cT0LZxsCGp63xHBJw7HNJocfSahzw@mail.gmail.com>
	<mdg18n$gsj$1@ger.gmane.org>
	<CAANLjFpH=0ZjXm2FKNF4Qz421jcM8QsW8HTDGpLqy5=w8POXQw@mail.gmail.com>
	<CAMXzGWK+8hpv0LOp6tAGft_=f8Peb9qackcLXruQH7qVVD9chQ@mail.gmail.com>
	<CAANLjFrwqr-znyMSBw=wCgiVkwqRT69ud3n0yAnhWUH=PZRTTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFrwqr-znyMSBw=wCgiVkwqRT69ud3n0yAnhWUH=PZRTTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Cc: Daniel Swarbrick <daniel.swarbrick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Robert,
    60 days ago, we enabled this feature in our production environment.
    It works for us.

    Did you see any flapping OSDs?

On Tue, Mar 10, 2015 at 1:16 PM, Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org> wrote:
> Jian,
>
> Thanks for the clarification. I'll mark traffic destined for the
> monitors as well. We are getting ready to put our first cluster into
> production. If you are interested we will be testing the heartbeat
> priority to see if we can saturate the network (not an easy task for
> 40 Gb) and keep the cluster from falling apart. Our network team is
> marking COS based on the DSCP and enforcing priority. We have three
> VLANs on bonded 40 GbE, management, storage (monitors, clients, OSDs),
> and cluster (replication). We have three priority classes management
> (heartbeats on all VLANs, SSH, DNS, etc), storage traffic (no
> marking), and replication (scavenger class). We are interested to see
> how things pan out.
>
> Thanks,
> Robert
>
> On Mon, Mar 9, 2015 at 8:58 PM, Jian Wen <wenjianhn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Only OSD calls set_socket_priority().
>> See  https://github.com/ceph/ceph/pull/3353
>>
>> On Tue, Mar 10, 2015 at 3:36 AM, Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org> wrote:
>>> I've found commit 9b9a682fe035c985e416ee1c112fa58f9045a27c and I see
>>> that when 'osd heartbeat use min delay socket = true' it will mark the
>>> packet with DSCP CS6. Based on the setting of the socket in
>>> msg/simple/Pipe.cc is it possible that this can apply to both OSD and
>>> monitor? I don't understand the code enough to know how the
>>> set_socket_options() is called from the OSD and monitor.
>>>
>>> If this applies to both monitor and OSD, would it be better to rename
>>> the option to a more generic name?
>>>
>>> Thanks,
>>>
>>> On Sat, Mar 7, 2015 at 4:23 PM, Daniel Swarbrick
>>> <daniel.swarbrick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>> Judging by the commit, this ought to do the trick:
>>>>
>>>> osd heartbeat use min delay socket = true
>>>>
>>>> On 07/03/15 01:20, Robert LeBlanc wrote:
>>>>>
>>>>> I see that Jian Wen has done work on this for 0.94. I tried looking
>>>>> through the code to see if I can figure out how to configure this new
>>>>> option, but it all went over my head pretty quick.
>>>>>
>>>>> Can I get a brief summary on how to set the priority of heartbeat
>>>>> packets or where to look in the code to figure it out?
>>>>>
>>>>> Thanks,
>>>>>
>>>>> On Thu, Aug 28, 2014 at 2:01 AM, Daniel Swarbrick
>>>>> <daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org
>>>>> <mailto:daniel.swarbrick-EIkl63zCoXaH+58JC4qpiA@public.gmane.org>> wrote:
>>>>>
>>>>>     On 28/08/14 02:56, Sage Weil wrote:
>>>>>     > I seem to remember someone telling me there were hooks/hints you
>>>>> could
>>>>>     > call that would tag either a socket or possibly data on that socket
>>>>> with a
>>>>>     > label for use by iptables and such.. but I forget what it was.
>>>>>     >
>>>>>
>>>>>     Something like setsockopt() SO_MARK?
>>>>>
>>>>>             *SO_MARK *(since Linux 2.6.25)
>>>>>                    Set the mark for each packet sent through this socket
>>>>>     (similar
>>>>>                    to the netfilter MARK target but socket-based).
>>>>>     Changing the
>>>>>                    mark can be used for mark-based routing without
>>>>>     netfilter or
>>>>>                    for packet filtering.  Setting this option requires the
>>>>>                    *CAP_NET_ADMIN *capability.
>>>>>
>>>>>     Alternatively, directly set IP_TOS options on the socket, or
>>>>> SO_PRIORITY
>>>>>     which sets the IP TOS bits as well.
>>>>>
>>>>>
>>>>>     _______________________________________________
>>>>>     ceph-users mailing list
>>>>>     ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>>>     <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>>>>>     http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> ceph-users mailing list
>>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>>
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
>>
>> --
>> Best,
>>
>> Jian



-- 
Best,

Jian
