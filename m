From: Ernesto Puerta <epuertat-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mgr/dashboard: backporting Ceph Dashboard v2 to
 Luminous
Date: Thu, 23 Aug 2018 12:47:47 +0200
Message-ID: <CAE8CVBCkfzGg9sFEZZtMqTWY51sof1=mVq0CA378i0PiVsmdtw@mail.gmail.com>
References: <CAE8CVBBRng2Bp+FZNKc+ocH+GD=YtPNa6rFG7T+N_x3L=MVZ9g@mail.gmail.com>
 <ba0d2586-865a-fcdb-5f8a-85755de7107d@digiware.nl>
 <CAE8CVBATwGPmqHmdV2sSMyB5BCHD8XuiOg0AxXKX-GK_WpxkrA@mail.gmail.com>
 <CAN-Gep+P2AeHs8q+3Af1YDNbUGA4ceVYL=-Za_anrzg2xDa9vA@mail.gmail.com>
 <89b3285e-b5d7-4eba-1c34-df39354ae5f4@suse.com>
 <72fa2792-6257-36ae-aec2-357a5d452f6c@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <72fa2792-6257-36ae-aec2-357a5d452f6c-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Thanks all for sharing your views, and thanks to Lenz & Kai for the
clarifications.

For those, like David, not familiar with dashboard_v2 (or even with
dashboard_v1), you may check this short clip
(https://youtu.be/m5i3x4eR6k4), which goes through the dashboard_v2 as
per this first backport (feature par with v1).

As Lenz said, the improvement in operability this brings in to
Luminous largely exceed its cost (doable yet tough) and risks (limited
as long as dashboard_v2 is a ceph-mgr python module), and makes this
move worthwhile for both new and existing Ceph users.

@Willem, given your comments come from a technical ground, let's
address those technically. As you say, dashboard_v2 is already in
Mimic and will be soon in Nautilus when released, so for FreeBSD the
issue will anyhow be there. Let's look for a technical solution (both
short and long-term): shall we have meeting to handle the FreeBSD
specifics?

Kind Regards,
Ernesto
