From: Ric Wheeler <rwheeler-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Introducing Tendrl
Date: Tue, 20 Sep 2016 21:38:16 +0300
Message-ID: <534f3d2f-a172-ecc9-f8d3-f60f8d8d9b60@redhat.com>
References: <CAOLAhP1dRqPFuVNPuOXfSktQdHEmuX-88iPb94RkWkm6AbS4+w@mail.gmail.com>
	<CAGrH30W5nz8hb+RcUt+gSPJRPUJ4ptLn2goc-EWsqapBKJSCfw@mail.gmail.com>
	<c89afa54-57b5-3977-2d43-fa730e932a79@redhat.com>
	<C1095376-CEC1-4B8C-9F1A-4157408FEFB5@julianfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org>
In-Reply-To: <C1095376-CEC1-4B8C-9F1A-4157408FEFB5-Fcm6T8Fmt17HuhbChzYfaQ@public.gmane.org>
List-Unsubscribe: <http://www.gluster.org/mailman/options/gluster-devel>,
	<mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <http://www.gluster.org/pipermail/gluster-devel/>
List-Post: <mailto:gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <http://www.gluster.org/mailman/listinfo/gluster-devel>,
	<mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=subscribe>
Sender: gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
Errors-To: gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
To: Joe Julian <joe-Fcm6T8Fmt17HuhbChzYfaQ@public.gmane.org>, Gerard Braad <me-+lKzbiBlNwRmR6Xm/wNWPw@public.gmane.org>, Mrugesh Karnik <mkarnik-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gluster Development <gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 09/20/2016 08:09 PM, Joe Julian wrote:
> Does this compare to ViPR?

I am not a ViPR expert, you would have to poke John Mark Walker for that :)

My assumption is that they might want to use these modules (from tendryl down to 
the ceph/gluster bits) to add support for ceph and gluster.

Regards,

Ric

>
> On September 20, 2016 9:52:54 AM PDT, Ric Wheeler <rwheeler-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
>     On 09/20/2016 10:23 AM, Gerard Braad wrote:
>
>         Hi Mrugesh, On Tue, Sep 20, 2016 at 3:10 PM, Mrugesh Karnik
>         <mkarnik-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
>             I'd like to introduce the Tendrl project. Tendrl aims to build a
>             management interface for Ceph. We've pushed some documentation to the 
>
>         On Tue, Sep 20, 2016 at 3:15 PM, Mrugesh Karnik <mkarnik-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>         wrote:
>
>             I'd like to introduce the Tendrl project. Tendrl aims to build a
>             management interface for Gluster. We've pushed some documentation to 
>
>         It might help to introduce Tendrl as the "Universal Storage Manager'"
>         with a possibility to either manage Ceph and/or Gluster. I understand
>         you want specific feedback, but a clear definition of the tool would
>         be helpful.
>
>
>
>     (Apologies for reposting my response - gmail injected html into what I thought
>     was a text reply and it bounced from ceph-devel.)
>
>     Hi Gerard,
>
>     I see the goal differently.
>
>     It is better to think of tendryl as one component of a whole management
>     application stack. At the bottom, we will have ceph specific components
>     (ceph-mgr) and gluster specific components (glusterd), as well as other local
>     storage/file system components like libstoragemgt and so on.
>
>     Tendryl is the next layer up from that, but it itself is meant to be consumed by
>     presentation layers. For a stand alone thing that we hope to use at Red Hat,
>     there will be a universal storage manager stack with everything I mentioned
>     above in it, as
>     well as the GUI code.
>
>     Other projects will hopefully find this useful enough and plug some or all of
>     the components into other management stacks.
>
>       From my point of view, the job is to try to provide as much as possible
>     re-usable components that will be generically interesting to a wide variety of
>     applications. It is definitely not about trying to make all storage stacks look
>     the same and force artificial new names/concepts/etc on the users. Of course,
>     any one application will tend to have a similar "skin" for UX elements to try
>     and make it consistent for users.
>
>     If we do it right, people passionate about Ceph but who don't care about Gluster
>     will be able to be avoid getting tied up in something out of their interest.
>     Same going the other way around for Gluster developers who don't care or know
>     about Ceph. Over time, this might extend to other storage types like Samba or
>     NFS Ganesha clusters,
>     etc.
>
>     Regards,
>
>     Ric
>
