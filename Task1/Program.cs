using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Task1
{

    class Program
    {
        static void Main(string[] args)
        {
            Figure[] figures = { new Triangle(8, 10, 15, MessageDialog),
                                 new Circle(4),
                                 new Circle(5),
                                 new Triangle(7, 8, 9, MessageDialog)
            };
            foreach (var item in figures)
            {
                Console.WriteLine(item.ToString());
            }
        }

        static void MessageDialog(string message) => Console.WriteLine(message);
    }
}
