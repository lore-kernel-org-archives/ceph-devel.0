From: Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org>
Subject: Re: IRC channels now require registered and identified
 users
Date: Tue, 18 Dec 2018 11:34:40 +0000
Message-ID: <8cdb553c-67fc-a441-aea7-890d37e978fc@suse.de>
References: <ce0a9512-e2cc-8eba-6c0e-226c8351bddf@suse.de>
 <CABZ+qqn+iR6j_kk_RsUastNvysbZzUqMRGHfa7P9x+rwCY4M1w@mail.gmail.com>
 <c1e28839-a3b5-61cf-28be-878a9e539e7e@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <c1e28839-a3b5-61cf-28be-878a9e539e7e-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 12/18/2018 11:22 AM, Joao Eduardo Luis wrote:
> On 12/18/2018 11:18 AM, Dan van der Ster wrote:
>> Hi Joao,
>>
>> Has that broken the Slack connection? I can't tell if its broken or
>> just quiet... last message on #ceph-devel was today at 1:13am.
> 
> Just quiet, it seems. Just tested it and the bridge is still working.

Okay, turns out the ceph-ircslackbot user is not identified, and that
makes it unable to send messages to the channel. This means the bridge
is working in one direction only (irc to slack), and will likely break
when/if the user leaves the channel (as it won't be able to get back in).

I will figure out just how this works today. In the mean time, I've
relaxed the requirement for registered/identified users so that the bot
works again. It will be reactivated once this is addressed.

  -Joao
