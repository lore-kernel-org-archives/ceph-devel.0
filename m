From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2] block: rbd: update sysfs interface
Date: Mon, 26 Feb 2018 16:16:54 +0100
Message-ID: <CAOi1vP80mMCtbB8GdM_mU=3MbH+orWOK6-54Hx+Nsa39D8xfjg@mail.gmail.com>
References: <20180223101959.GA4441@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180223101959.GA4441@mordor.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

On Fri, Feb 23, 2018 at 11:19 AM, Aishwarya Pant <aishpant@gmail.com> wrote:
> The existing sysfs interface has been updated to be in the same format
> as described in Documentation/ABI/README. This will be useful for
> scripting and tracking changes in the ABI. Attributes have been grouped
> by functionality and/or the date on which they were added.
>
> There are a couple of more changes:
> - The attributes have been annotated with file permissions RO/RW/WO.
> - Added description of the bus attribute supported_features
>
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
> Changes in v2:
> - Update dates and kernel version. Sorry, my scripts have been acting up :/
> - Update contact information. Would it be more appropriate to use the mailing
>   list ceph-devel@vger.kernel.org in the contact section?
> - (WO) -> (RO) in image_id
> - Fix typo pool_idr -> pool_id
>
>  Documentation/ABI/testing/sysfs-bus-rbd | 203 +++++++++++++++++++-------------
>  1 file changed, 122 insertions(+), 81 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
> index f208ac58d613..cc30bee8b5f4 100644
> --- a/Documentation/ABI/testing/sysfs-bus-rbd
> +++ b/Documentation/ABI/testing/sysfs-bus-rbd
> @@ -1,121 +1,162 @@
> -What:          /sys/bus/rbd/
> -Date:          November 2010
> -Contact:       Yehuda Sadeh <yehuda@newdream.net>,
> -               Sage Weil <sage@newdream.net>
> +What:          /sys/bus/rbd/add
> +Date:          Oct, 2010
> +KernelVersion: v2.6.37
> +Contact:       Sage Weil <sage@newdream.net>
>  Description:
> +               (WO) Add rbd block device.
>
> -Being used for adding and removing rbd block devices.
> +               Usage: <mon ip addr> <options> <pool name> <rbd image name> [<snap name>]
>
> -Usage: <mon ip addr> <options> <pool name> <rbd image name> [<snap name>]
> +                $ echo "192.168.0.1 name=admin rbd foo" > /sys/bus/rbd/add
>
> - $ echo "192.168.0.1 name=admin rbd foo" > /sys/bus/rbd/add
> +               The snapshot name can be "-" or omitted to map the image
> +               read/write. A <dev-id> will be assigned for any registered block
> +               device. If snapshot is used, it will be mapped read-only.
>
> -The snapshot name can be "-" or omitted to map the image read/write. A <dev-id>
> -will be assigned for any registered block device. If snapshot is used, it will
> -be mapped read-only.
>
> -Usage: <dev-id> [force]
> +What:          /sys/bus/rbd/remove
> +Date:          Oct, 2010
> +KernelVersion: v2.6.37
> +Contact:       Sage Weil <sage@newdream.net>
> +Description:
> +               (WO) Remove rbd block device.
> +
> +               Usage: <dev-id> [force]
>
> - $ echo 2 > /sys/bus/rbd/remove
> +                $ echo 2 > /sys/bus/rbd/remove
> +
> +               Optional "force" argument which when passed will wait for
> +               running requests and then unmap the image. Requests sent to the
> +               driver after initiating the removal will be failed. (August
> +               2016, since 4.9.)
>
> -Optional "force" argument which when passed will wait for running requests and
> -then unmap the image. Requests sent to the driver after initiating the removal
> -will be failed.  (August 2016, since 4.9.)
>
>  What:          /sys/bus/rbd/add_single_major
> -Date:          December 2013
> -KernelVersion: 3.14
> -Contact:       Sage Weil <sage@inktank.com>
> -Description:   Available only if rbd module is inserted with single_major
> +Date:          Dec, 2013
> +KernelVersion: v3.14
> +Contact:       Sage Weil <sage@newdream.net>
> +Description:
> +               (WO) Available only if rbd module is inserted with single_major
>                 parameter set to true.
> -               Usage is the same as for /sys/bus/rbd/add.  If present,
> +
> +               Usage is the same as for /sys/bus/rbd/add. If present, this
>                 should be used instead of the latter: any attempts to use
> -               /sys/bus/rbd/add if /sys/bus/rbd/add_single_major is
> -               available will fail for backwards compatibility reasons.
> +               /sys/bus/rbd/add if /sys/bus/rbd/add_single_major is available
> +               will fail for backwards compatibility reasons.
> +
>
>  What:          /sys/bus/rbd/remove_single_major
> -Date:          December 2013
> -KernelVersion: 3.14
> -Contact:       Sage Weil <sage@inktank.com>
> -Description:   Available only if rbd module is inserted with single_major
> +Date:          Dec, 2013
> +KernelVersion: v3.14
> +Contact:       Sage Weil <sage@newdream.net>
> +Description:
> +               (WO) Available only if rbd module is inserted with single_major
>                 parameter set to true.
> -               Usage is the same as for /sys/bus/rbd/remove.  If present,
> +
> +               Usage is the same as for /sys/bus/rbd/remove. If present, this
>                 should be used instead of the latter: any attempts to use
>                 /sys/bus/rbd/remove if /sys/bus/rbd/remove_single_major is
>                 available will fail for backwards compatibility reasons.
>
> -Entries under /sys/bus/rbd/devices/<dev-id>/
> ---------------------------------------------
> -
> -client_addr
> -
> -       The ceph unique client entity_addr_t (address + nonce).
> -       The format is <address>:<port>/<nonce>: '1.2.3.4:1234/5678' or
> -       '[1:2:3:4:5:6:7:8]:1234/5678'.  (August 2016, since 4.9.)
> -
> -client_id
> -
> -       The ceph unique client id that was assigned for this specific session.
> -
> -cluster_fsid
>
> -       The ceph cluster UUID.  (August 2016, since 4.9.)
> -
> -config_info
> -
> -       The string written into /sys/bus/rbd/add{,_single_major}.  (August
> -       2016, since 4.9.)
> -
> -features
> -
> -       A hexadecimal encoding of the feature bits for this image.
> -
> -major
> -
> -       The block device major number.
> +What:          /sys/bus/rbd/supported_features
> +Date:          Mar, 2017
> +KernelVersion: v4.11
> +Contact:       Sage Weil <sage@newdream.net>
> +Description:
> +               (RO) Displays the features supported by the rbd module so that
> +               userspace can generate meaningful error messages and spell out
> +               unsupported features that need to be disabled.
> +
> +
> +What:          /sys/bus/rbd/devices/<dev-id>/size
> +What:          /sys/bus/rbd/devices/<dev-id>/major
> +What:          /sys/bus/rbd/devices/<dev-id>/client_id
> +What:          /sys/bus/rbd/devices/<dev-id>/pool
> +What:          /sys/bus/rbd/devices/<dev-id>/name
> +What:          /sys/bus/rbd/devices/<dev-id>/refresh
> +What:          /sys/bus/rbd/devices/<dev-id>/current_snap
> +Date:          Oct, 2010
> +KernelVersion: v2.6.37
> +Contact:       Sage Weil <sage@newdream.net>
> +Description:
> +               size:           (RO) The size (in bytes) of the mapped block
> +                               device.
>
> -minor
> +               major:          (RO) The block device major number.
>
> -       The block device minor number.  (December 2013, since 3.14.)
> +               client_id:      (RO) The ceph unique client id that was assigned
> +                               for this specific session.
>
> -name
> +               pool:           (RO) The name of the storage pool where this rbd
> +                               image resides. An rbd image name is unique
> +                               within its pool.
>
> -       The name of the rbd image.
> +               name:           (RO) The name of the rbd image.
>
> -image_id
> +               refresh:        (WO) Writing to this file will reread the image
> +                               header data and set all relevant data structures
> +                               accordingly.
>
> -       The unique id for the rbd image.  (For rbd image format 1
> -       this is empty.)
> +               current_snap:   (RO) The current snapshot for which the device
> +                               is mapped.
>
> -pool
>
> -       The name of the storage pool where this rbd image resides.
> -       An rbd image name is unique within its pool.
> +What:          /sys/bus/rbd/devices/<dev-id>/pool_id
> +Date:          Jul, 2012
> +KernelVersion: v3.6
> +Contact:       Sage Weil <sage@newdream.net>
> +Description:
> +               (RO) The unique identifier for the rbd image's pool. This is a
> +               permanent attribute of the pool. A pool's id will never change.
>
> -pool_id
>
> -       The unique identifier for the rbd image's pool.  This is
> -       a permanent attribute of the pool.  A pool's id will never
> -       change.
> +What:          /sys/bus/rbd/devices/<dev-id>/image_id
> +What:          /sys/bus/rbd/devices/<dev-id>/features
> +Date:          Oct, 2012
> +KernelVersion: v3.7
> +Contact:       Sage Weil <sage@newdream.net>
> +Description:
> +               image_id:       (RO) The unique id for the rbd image. (For rbd
> +                               image format 1 this is empty.)
>
> -size
> +               features:       (RO) A hexadecimal encoding of the feature bits
> +                               for this image.
>
> -       The size (in bytes) of the mapped block device.
>
> -refresh
> +What:          /sys/bus/rbd/devices/<dev-id>/parent
> +Date:          Nov, 2012
> +KernelVersion: v3.8
> +Contact:       Sage Weil <sage@newdream.net>
> +Description:
> +               (RO) Information identifying the chain of parent images in a
> +               layered rbd image. Entries are separated by empty lines.
>
> -       Writing to this file will reread the image header data and set
> -       all relevant datastructures accordingly.
>
> -current_snap
> +What:          /sys/bus/rbd/devices/<dev-id>/minor
> +Date:          Dec, 2013
> +KernelVersion: v3.14
> +Contact:       Sage Weil <sage@newdream.net>
> +Description:
> +               (RO) The block device minor number.
>
> -       The current snapshot for which the device is mapped.
>
> -snap_id
> +What:          /sys/bus/rbd/devices/<dev-id>/snap_id
> +What:          /sys/bus/rbd/devices/<dev-id>/config_info
> +What:          /sys/bus/rbd/devices/<dev-id>/cluster_fsid
> +What:          /sys/bus/rbd/devices/<dev-id>/client_addr
> +Date:          Aug, 2016
> +KernelVersion: v4.9
> +Contact:       Sage Weil <sage@newdream.net>
> +Description:
> +               snap_id:        (RO) The current snapshot's id.
>
> -       The current snapshot's id.  (August 2016, since 4.9.)
> +               config_info:    (RO) The string written into
> +                               /sys/bus/rbd/add{,_single_major}.
>
> -parent
> +               cluster_fsid:   (RO) The ceph cluster UUID.
>
> -       Information identifying the chain of parent images in a layered rbd
> -       image.  Entries are separated by empty lines.
> +               client_addr:    (RO) The ceph unique client
> +                               entity_addr_t (address + nonce). The format is
> +                               <address>:<port>/<nonce>: '1.2.3.4:1234/5678' or
> +                               '[1:2:3:4:5:6:7:8]:1234/5678'.

Applied.

Thanks,

                Ilya
