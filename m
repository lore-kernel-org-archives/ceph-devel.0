From: Dan Mick <dmick-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: tracker.ceph.com downtime today
Date: Thu, 22 Oct 2015 18:54:04 -0700
Message-ID: <5629933C.1060901@redhat.com>
References: <56296119.5040807@redhat.com> <56296C9B.70207@redhat.com>
	<56297692.3090004@redhat.com> <56298A4B.9030705@redhat.com>
	<CAMieVSc6Cx3j1i9vK4qVhBmRcvMX9NYE2j9ygCOHMwomPSrYcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMieVSc6Cx3j1i9vK4qVhBmRcvMX9NYE2j9ygCOHMwomPSrYcw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Kyle Bader <kbader-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

I see that too.  I suspect this is because of leftover database columns
from the backlogs plugin, which is removed.  Looking into it.

On 10/22/2015 06:43 PM, Kyle Bader wrote:
> I tried to open a new issue and got this error:
> 
> Internal error
> 
> An error occurred on the page you were trying to access.
> If you continue to experience problems please contact your Redmine
> administrator for assistance.
> 
> If you are the Redmine administrator, check your log files for details
> about the error.
> 
> 
> On Thu, Oct 22, 2015 at 6:15 PM, Dan Mick <dmick-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> Fixed a configuration problem preventing updating issues, and switched
>> the mailer to use ipv4; if you updated and failed, or missed an email
>> notification, that may have been why.
>>
>> On 10/22/2015 04:51 PM, Dan Mick wrote:
>>> It's back.  New DNS info is propagating its way around.  If you
>>> absolutely must get to it, newtracker.ceph.com is the new address, but
>>> please don't bookmark that, as it will be going away after the transition.
>>>
>>> Please let me know of any problems you have.
>>
>> ---
>> Note: This list is intended for discussions relating to Red Hat Storage products, customers and/or support. Discussions on GlusterFS and Ceph architecture, design and engineering should go to relevant upstream mailing lists.
> 
> 
> 
