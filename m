From: Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
Subject: Re: mgr/dashboard: backporting Ceph Dashboard v2 to
 Luminous
Date: Thu, 23 Aug 2018 13:06:49 +0200
Message-ID: <eb63858d-51e4-2cf4-a264-6a9f74b740a0@digiware.nl>
References: <CAE8CVBBRng2Bp+FZNKc+ocH+GD=YtPNa6rFG7T+N_x3L=MVZ9g@mail.gmail.com>
 <ba0d2586-865a-fcdb-5f8a-85755de7107d@digiware.nl>
 <CAE8CVBATwGPmqHmdV2sSMyB5BCHD8XuiOg0AxXKX-GK_WpxkrA@mail.gmail.com>
 <CAN-Gep+P2AeHs8q+3Af1YDNbUGA4ceVYL=-Za_anrzg2xDa9vA@mail.gmail.com>
 <89b3285e-b5d7-4eba-1c34-df39354ae5f4@suse.com>
 <72fa2792-6257-36ae-aec2-357a5d452f6c@digiware.nl>
 <CAE8CVBCkfzGg9sFEZZtMqTWY51sof1=mVq0CA378i0PiVsmdtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAE8CVBCkfzGg9sFEZZtMqTWY51sof1=mVq0CA378i0PiVsmdtw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ernesto Puerta <epuertat-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 23/08/2018 12:47, Ernesto Puerta wrote:

> @Willem, given your comments come from a technical ground, let's
> address those technically. As you say, dashboard_v2 is already in
> Mimic and will be soon in Nautilus when released, so for FreeBSD the
> issue will anyhow be there. Let's look for a technical solution (both
> short and long-term): shall we have meeting to handle the FreeBSD
> specifics?

I have bit more time than that...
Usually I start makeing a port once the release is stable, so in this 
case 14.2.x. Becaue the FreeBSD users that like to live dangerously 
usually can also build their own source from the repo.

But you right, one day I need to bite the bullit.

ATM I'm contemplating all kinds of scenarios to make it workable for all 
participants: devs, porters, users. And I haven't really found the 
golden egg.
So yes, lets take it private and talk.

--WjW
