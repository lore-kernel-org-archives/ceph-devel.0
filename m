From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: OSD rebind connects to ports of other OSDs
Date: Tue, 20 Dec 2016 17:48:33 +0100
Message-ID: <f1963dc8-2c2e-04bb-ea05-849e051631c2@digiware.nl>
References: <2b061067-e839-054e-5166-619deecfae5e@digiware.nl>
 <20161220150636.GA1510@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:54947 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934237AbcLTQsk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Dec 2016 11:48:40 -0500
In-Reply-To: <20161220150636.GA1510@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <to.my.trociny@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 20-12-2016 16:06, Mykola Golub wrote:
> This is due to SO_REUSEADDR (not SO_REUSEPORT) socket option set. You
> should have mentioned that you were talking about FreeBSD.
Hi Mykola,

Sorry, I normally do. Since I know there are subtile differences.

> Note, although osd-0 and osd-1 processes are bound to the same port,
> they have different addresses: wildcard (*) for osd-1, and 127.0.0.1
> for rebound osd-0. On FreeBSD if SO_REUSEADDR is set, it fails to bind
> only when both address and port are the same, and wildcard is
> considered as a different address here. On Linux bind fails in such
> case.

I suspected something like this, but if I try to simulate this in a
program. I still get 'address in use' when I first bind to *:port, and
then to 127.0.0.1:port.
So that makes it rather vague.

> See, for example this for more details:
> 
> http://stackoverflow.com/questions/14388706/socket-options-so-reuseaddr-and-so-reuseport-how-do-they-differ-do-they-mean-t

Interesting article, archived it with the other stuff I already have
from the FreeBSD lists where there is also a lot off misunderstanding on
this topic.

> The question is though why it rebinds to 127.0.0.1, and not to '*'? I
> suppose this is wrong. How does it behave on Linux?

Similar:
First round of binds:
2016-12-12 23:57:37.615409 7f36c2be6940  1 -- 0.0.0.0:6800/13799
_finish_bind bind my_inst.addr is 0.0.0.0:6800/13799
2016-12-12 23:57:37.615739 7f36c2be6940  1 -- 0.0.0.0:6801/13799
_finish_bind bind my_inst.addr is 0.0.0.0:6801/13799
2016-12-12 23:57:37.616090 7f36c2be6940  1 -- 0.0.0.0:6802/13799
_finish_bind bind my_inst.addr is 0.0.0.0:6802/13799
2016-12-12 23:57:37.616452 7f36c2be6940  1 -- 0.0.0.0:6803/13799
_finish_bind bind my_inst.addr is 0.0.0.0:6803/13799

So that is to INADDR_ANY

rebinds:
2016-12-12 23:57:50.094446 7f36b5ac6700  1 -- 127.0.0.1:6812/1013799
_finish_bind bind my_inst.addr is 127.0.0.1:6812/1013799
2016-12-12 23:57:50.094956 7f36b5ac6700  1 -- 127.0.0.1:6813/1013799
_finish_bind bind my_inst.addr is 127.0.0.1:6813/1013799
2016-12-12 23:57:50.095477 7f36b5ac6700  1 -- 127.0.0.1:6814/1013799
_finish_bind bind my_inst.addr is 127.0.0.1:6814/1013799

so that is on the hostname as specified in the config.

So your suggestion would be to not bind on INADDR_ANY but on the config
hostname with the initial bind as well??

Also i got Email from Sage, stating that SO_REUSEADDR not working is not
too bad, since it is mainly to prevent running out of ports when they
are cycled thru high speed.

--WjW

> 
> On Tue, Dec 20, 2016 at 11:21:19AM +0100, Willem Jan Withagen wrote:
>> Hi,
>>
>> I've been banging my head against the wall for some time now.
>> But rebinding OSD.0 (in cephtool-test-mon.sh) does not quite work.
>>
>> When rebinding it connects to the ports of OSD.1 because those ports are
>> the first not in the avoid_list. That should be refused since these
>> sockets belong to a different process.
>> UNLESS SO_REUSEPORT is set:
>>  SO_REUSEPORT allows completely duplicate bindings by multiple processes
>>  if they all set SO_REUSEPORT before binding the port.  This option
>>  permits multiple instances of a program to each receive UDP/IP
>>  multicast or broadcast datagrams destined for the bound port.
>>
>> Which seems that that happens.
>> Output from sockstat in this state:
>> wjw      ceph-osd-0   43305 14 tcp4   *:6800                *:*
>> wjw      ceph-osd-0   43305 15 tcp4   127.0.0.1:6804        *:*
>> wjw      ceph-osd-0   43305 16 tcp4   127.0.0.1:6805        *:*
>> wjw      ceph-osd-0   43305 45 tcp4   127.0.0.1:6806        *:*
>> wjw      ceph-osd-1   43318 14 tcp4   *:6804                *:*
>> wjw      ceph-osd-1   43318 15 tcp4   *:6805                *:*
>> wjw      ceph-osd-1   43318 16 tcp4   *:6806                *:*
>> wjw      ceph-osd-1   43318 17 tcp4   *:6807                *:*
>>
>> Which clearly demonstrates the mess.
>> How ever that option is nowhere set in the ceph-code, neither is it a
>> setting that "just" gets set.
>>
>> Any suggestions where to look for this option to get set in an
>> incidental/bug way would be much appreciated.
>> Or a suggestion on how to easily debug this.
>>
>> Thanx,
>> --WjW
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

