From: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: shared images
Date: Mon, 13 May 2013 11:37:53 -0700
Message-ID: <CAPYLRzhYfipj2xuSc2oNHftg3RGkawDmL1Bjf_mDa+QbsjoBrw@mail.gmail.com>
References: <1368461414.21953.4.camel@lde-hro-01>
	<CAPYLRzjU6f0HqmKOpX=Ct2WQNCT-ukxYUEVr7VNXSYOpKPW7rA@mail.gmail.com>
	<1368470109.28923.9.camel@lde-hro-01>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <1368470109.28923.9.camel@lde-hro-01>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: =?ISO-8859-1?Q?Harald_R=F6=DFler?= <Harald.Roessler-hek4QReFJEw@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, May 13, 2013 at 11:35 AM, Harald R=F6=DFler <Harald.Roessler-hek4QReFJEw@public.gmane.org=
> wrote:
> On Mon, 2013-05-13 at 18:55 +0200, Gregory Farnum wrote:
>> On Mon, May 13, 2013 at 9:10 AM, Harald R=F6=DFler <Harald.Roessler@btd.=
de> wrote:
>> >
>> > Hi Together
>> >
>> > is there a description of how a shared image works in detail? Can such
>> > an image can be used for a shared file system on two virtual machine
>> > (KVM) to mount. In my case, write on one machine and read only on the
>> > other KVM.Are the changes are visible on the read only KVM?
>>
>> The image is just striped across RADOS objects. In general you can
>> think of it behaving exactly like a hard drive connected to your
>> computer over iSCSI =97 a proper shared FS (eg, OCFS2) will work on top
>> of it, but there's no magic that makes running an ext4 mount on two
>> machines work...
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
> Hi Greg
>
> Thanks, and sorry maybe I did not explain clearly what I  mean or. When
> I' mounting a rbd image on two KVM machines, then if I am writing a file
> in one system the other system does not recognize the change of the file
> system. I thought there is some magic in librbd which give the OS the
> information that something have changed, like when I am mounting a NFS
> share.
>
> I saw in the documentation the "--shared tag" :
>
> Option for lock add that allows multiple clients to lock the same image
> if they use the same tag. The tag is an arbitrary string. This is useful
> for situations where an image must be open from more than one client at
> once, like during live migration of a virtual machine, or for use
> underneath a clustered file system.
>
> The use case is multiply KVM systems are mounting the same data storage,
> without use of cephfs (MDS).

Yeah, that absolutely will not work. RBD is a block device, not a
shared filesystem. ;)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
