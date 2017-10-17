From: Mohamad Gebai <mgebai-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Unstable clock
Date: Tue, 17 Oct 2017 09:40:18 -0400
Message-ID: <9079f6c0-e37e-74c7-4fcb-4f5fd55cf482@suse.de>
References: <085064b4-2e21-4e54-cdd8-dd8a4560aa92@suse.de>
 <alpine.DEB.2.11.1710171325500.26702@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1710171325500.26702-ie3vfNGmdjePKud3HExfWg@public.gmane.org>
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
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


On 10/17/2017 09:27 AM, Sage Weil wrote:
> On Tue, 17 Oct 2017, Mohamad Gebai wrote:
>
>> It would be good to know if there are any, and maybe prepare for them?
> Adam added a new set of clock primitives that include a monotonic clock 
> option that should be used in all cases where we're measuring the passage 
> of time instead of the wall clock time.  There is a longstanding trello 
> card to go through and change the latency calculations to use the 
> monotonic clock.  There are probably dozens of places where an ill-timed 
> clock jump is liable to trigger some random assert.  It's just a matter of 
> going through and auditing calls to the legacy ceph_clock_now() method.
>

Thanks Sage. I assume that's the card you're referring to:
https://trello.com/c/SAtGPq0N/65-use-time-span-monotonic-for-durations

I can take of that one if no one else has started working on it.

Mohamad
