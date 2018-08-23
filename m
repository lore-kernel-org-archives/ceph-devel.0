From: Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
Subject: Re: mgr/dashboard: backporting Ceph Dashboard v2 to
 Luminous
Date: Thu, 23 Aug 2018 12:33:34 +0200
Message-ID: <72fa2792-6257-36ae-aec2-357a5d452f6c@digiware.nl>
References: <CAE8CVBBRng2Bp+FZNKc+ocH+GD=YtPNa6rFG7T+N_x3L=MVZ9g@mail.gmail.com>
 <ba0d2586-865a-fcdb-5f8a-85755de7107d@digiware.nl>
 <CAE8CVBATwGPmqHmdV2sSMyB5BCHD8XuiOg0AxXKX-GK_WpxkrA@mail.gmail.com>
 <CAN-Gep+P2AeHs8q+3Af1YDNbUGA4ceVYL=-Za_anrzg2xDa9vA@mail.gmail.com>
 <89b3285e-b5d7-4eba-1c34-df39354ae5f4@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <89b3285e-b5d7-4eba-1c34-df39354ae5f4-IBi9RG/b67k@public.gmane.org>
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
To: Lenz Grimmer <lgrimmer-IBi9RG/b67k@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 23/08/2018 11:22, Lenz Grimmer wrote:
> On 08/22/2018 08:57 PM, David Turner wrote:
> 
>> My initial reaction to this PR/backport was questioning why such a
>> major update would happen on a dot release of Luminous.  Your
>> reaction to keeping both dashboards viable goes to support that.
>> Should we really be backporting features into a dot release that
>> force people to change how they use the software?  That seems more of
>> the purpose of having new releases.
> 
> This is indeed an unusual case. But considering that the Dashboard does
> not really change any of the Ceph core functionality but adds a lot of
> value by improving the usability and manageability of Ceph, we agreed
> with Sage on making an exception here.
> 
>> I haven't really used either dashboard though.  Other than adding
>> admin functionality, does it remove any functionality of the previous
>> dashboard?
> 
> Like Kai wrote, our initial goal was to reach feature parity with
> Dashboard v1, in order to not introduce a regression when replacing it.
> 
> In the meanwhile, Dashboard v2 is way beyond that and we have added a
> lot of additional functionality, e.g. RBD and RGW management.
> 
> With backporting this to Luminous, we also hope to reach a larger
> audience of users that have not updated to Mimic yet.

Wierd approach question....

Is there still some "logic" separation between the v1 and v2 stuff?
And is it possible to build what is used to be v1 without importing the 
npm stuff? That way I can "easily" package and distribute that piece.

ATM this plan really cripples my possibilities to package a bit of 
dashboard... where L and M did have something workable.

Just keeping it in the tree as "dead wood" for the time being would help 
me get people a taste of what is there. Just ripping it out does not 
help. And I'll try to work out a solution before the release of 
Nautilus, or accept that it will be gone and has to be v2.

--WjW
