From: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: two osd stack on peereng after start osd to
	recovery
Date: Thu, 6 Jun 2013 11:21:39 -0700
Message-ID: <CAPYLRzjKJtVFbD43ZVsSY0DPu3EQhfXU71CWrp5B0b1JG6LUqQ@mail.gmail.com>
References: <CAMNMNTyzChZPCgf-aOWJCzg-0=J9qRj3YknuBrtzWHKWFT9P8Q@mail.gmail.com>
	<CAMNMNTxAT6esZ70OjeKTcW5rEL0Y5Tv8Xcs2x23Tj=Cx2Apudw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMNMNTxAT6esZ70OjeKTcW5rEL0Y5Tv8Xcs2x23Tj=Cx2Apudw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

We don't have your logs (vger doesn't forward them). Can you describe
the situation more completely in terms of what failures occurred and
what steps you took?
(Also, this should go on ceph-users. Adding that to the recipients list.)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Wed, Jun 5, 2013 at 4:20 PM, Dominik Mostowiec
<dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> hi,
> I have again the same problem.
> Have you got any idea?
>
> --
> Regards
> Dominik
>
> 2013/5/23 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> Hi,
>> I changed disk after failure (osd.155).
>> When osd.155 start on empty disk, and starts recovery, two osd stack
>> on peering (108 and 71).
>> Logs in attachment.
>> Restart (osd 108,71) helps.
>> ceph -v
>> ceph version 0.56.6 (95a0bda7f007a33b0dc7adf4b330778fa1e5d70c)
>>
>> setup:
>>
>> 6 servers x 26 osd
>> 6 x mons
>> journal and data on the same disk
